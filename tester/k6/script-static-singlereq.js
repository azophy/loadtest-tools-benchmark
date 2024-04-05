import http from 'k6/http';
import { check } from 'k6';

export const options = {
  scenarios: {
    loadtest: {
      /* refereces on selecting best executor for this scenario:
       * - https://community.grafana.com/t/from-wrk-to-k6-equivalent-parameters-and-testing-methodology/111033/5
       * - https://stackoverflow.com/questions/77742171/from-wrk-to-k6-equivalent-parameters-and-testing-methodology/77764031#77764031
       */
      executor: 'constant-vus',
      vus: __ENV.NUM_THREAD,
      duration: __ENV.DEFAULT_DURATION + 's',
    },
  },

  // reference: https://k6.io/docs/testing-guides/running-large-tests/#k6-options-to-reduce-resource-use
  discardResponseBodies: true,

  thresholds: {
    http_req_failed: [{ threshold: "rate<0.05", abortOnFail: true, delayAbortEval: '10s' }], // availability threshold for error rate
    http_req_duration: [{ threshold: "p(95)<1000", abortOnFail: true, delayAbortEval: '10s' }], // Latency threshold for percentile
  },
};

export default function () {
  const res = http.get(__ENV.TARGET_URL + '/k6/static-singlereq');
  check(res, { 'status was 200': (r) => r.status == 200 });
}
