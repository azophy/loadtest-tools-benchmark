'use strict'

let TARGET_URL = process.env.TARGET_URL
let DEFAULT_DURATION = process.env.DEFAULT_DURATION
if (TARGET_URL == undefined) {
  console.log('TARGET_URL env var is undefined')
  process.exit(1)
}

function randomString(length, charset='abcdefghijklmnopqrstuvwxyz') {
  let res = '';
  while (length--) res += charset[(Math.random() * charset.length) | 0];
  return res;
}
const autocannon = require('autocannon')

let instance = autocannon({
  url: 'http://target:3000/',
  connections: process.env.NUM_CONNECTIONS,
  pipelining: 6,
  //workers: process.env.NUM_THREAD,
  timeout: 1, // in second
  duration: process.env.DEFAULT_DURATION,
  setupRequest:  (req, context) => ({
    ...req,
    path: '/test/autocannon/dynamic-singlereq-setupreq?q=' + randomString(5),
  })
}, console.log)

// this is used to kill the instance on CTRL-C
process.once('SIGINT', () => {
  instance.stop()
})

// just render results
autocannon.track(instance, {})