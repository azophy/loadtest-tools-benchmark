function randomString(length, charset='abcdefghijklmnopqrstuvwxyz') {
  let res = '';
  while (length--) res += charset[(Math.random() * charset.length) | 0];
  return res;
}

export.setupRequest:  (req, context) => ({
  ...req,
  path: '/test/autocannon/dynamic-singlereq-setupreq-withworker?q=' + randomString(5),
})

