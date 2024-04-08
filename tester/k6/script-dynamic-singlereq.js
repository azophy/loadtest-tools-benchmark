import http from 'k6/http';
import { check } from 'k6';
import { randomString } from 'https://jslib.k6.io/k6-utils/1.2.0/index.js';
export { options } from './base.js'

export default function () {
  const url = __ENV.TARGET_URL + '/k6/dynamic-singlereq?q=' + randomString(5);
  const params = {
    tags: { name: 'k6_dynamic-singlereq' },
  };

  const res = http.get(url, params);
  check(res, { 'status was 200': (r) => r.status == 200 });
}
