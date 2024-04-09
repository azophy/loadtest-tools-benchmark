'use strict'

// taken from https://jslib.k6.io/k6-utils/1.2.0/index.js
function randomString(length, charset='abcdefghijklmnopqrstuvwxyz') {
   let res = '';
   while (length--) res += charset[(Math.random() * charset.length) | 0];
   return res;
}

module.exports = (req, context) => ({
  ...req,
  path: context.base_path + '?q=' + randomString(5),
})
