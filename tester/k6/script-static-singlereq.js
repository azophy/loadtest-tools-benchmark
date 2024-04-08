import http from 'k6/http';
import { check } from 'k6';
export { options } from './base.js'

export default function () {
  const res = http.get(__ENV.TARGET_URL + '/k6/static-singlereq');
  check(res, { 'status was 200': (r) => r.status == 200 });
}
