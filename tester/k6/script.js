import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  scenarios: {
    contacts: {
      executor: 'ramping-arrival-rate',
      preAllocatedVUs: 10000,
      timeUnit: '1s',
      stages: [
        { target: 50000, duration: '0' }, // instantly jump to 500 iters/s
        { target: 50000, duration: '60s' }, // continue with 500 iters/s for 10 minutes
      ],
    },
  },
};

export default function () {
  const res = http.get('http://target:3000/test/k6');
  check(res, { 'status was 200': (r) => r.status == 200 });
  sleep(1);
}
