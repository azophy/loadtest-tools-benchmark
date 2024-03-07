'use strict'

let TARGET_URL = process.env.TARGET_URL
let DEFAULT_DURATION = process.env.DEFAULT_DURATION
if (TARGET_URL == undefined) {
  console.log('TARGET_URL env var is undefined')
  process.exit(1)
}

const autocannon = require('autocannon')

let instance = autocannon({
  url: TARGET_URL + '/autocannon',
  connections: 1000, 
  pipelining: 6, 
  workers: 8,
  timeout: 1, // in second
  duration: DEFAULT_DURATION, 
}, console.log)

// this is used to kill the instance on CTRL-C
process.once('SIGINT', () => {
  instance.stop()
})

// just render results
autocannon.track(instance, {})
