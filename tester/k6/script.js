import http from 'k6/http';
import { check } from 'k6';

export const options = {
  scenarios: {
    contacts: {
      executor: 'ramping-arrival-rate',
      timeUnit: '1s',
      preAllocatedVUs: 1000,
      stages: [
        { target: 200000, duration: $__ENV.DEFAULT_DURATION + 's' }, // ramp-up to a HUGE load
      ],
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
  const res = http.get($__ENV.TARGET_URL + '/k6');
  check(res, { 'status was 200': (r) => r.status == 200 });
}
