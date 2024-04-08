import http from 'k6/http';
import { check } from 'k6';
import { randomString } from 'https://jslib.k6.io/k6-utils/1.2.0/index.js';
export { options } from './base.js'

export default function () {
  const url = __ENV.TARGET_URL + '/k6/dynamic-multireq?q=' + randomString(5);

  const res = http.get(url);
  check(res, { 'status was 200': (r) => r.status == 200 });

  const res2 = http.POST(url);
  check(res2, { 'status was 200': (r) => r.status == 200 });
}
