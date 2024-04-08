import http from 'k6/http';
import { check } from 'k6';
export { options} from './base.js'

export default function () {
  const url = __ENV.TARGET_URL + '/k6/static-multireq';

  const res = http.get(url);
  check(res, { 'status was 200': (r) => r.status == 200 });

  const res2 = http.post(url);
  check(res2, { 'status was 200': (r) => r.status == 200 });
}
