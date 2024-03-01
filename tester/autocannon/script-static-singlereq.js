'use strict'

let TARGET_URL = process.env.TARGET_URL
let DEFAULT_DURATION = process.env.DEFAULT_DURATION
if (TARGET_URL == undefined) {
  console.log('TARGET_URL env var is undefined')
  exit()
}

const autocannon = require('autocannon')

autocannon({
  url: TARGET_URL + '/autocannon',
  connections: 1000, 
  pipelining: 6, 
  workers: 8,
  timeout: 1, // in second
  duration: DEFAULT_DURATION, 
}, console.log)
