'use strict'

let TARGET_URL = process.env.TARGET_URL
let DEFAULT_DURATION = process.env.DEFAULT_DURATION
if (TARGET_URL == undefined) {
  console.log('TARGET_URL env var is undefined')
  process.exit(1)
}

const autocannon = require('autocannon')
const baseOptions = {
  url: TARGET_URL,
  connections: process.env.NUM_CONNECTIONS,
  pipelining: 6,
  workers: process.env.NUM_THREAD,
  timeout: 1, // in second
  duration: process.env.DEFAULT_DURATION,
  idReplacement: true,
}

function runAutocannonScenario(requests, base_path) {
  let finalOptions = {
    ...baseOptions,
    requests,
  }

  if (base_path) {
    finalOptions.initialContext = { base_path }
  }

  let instance = autocannon(finalOptions, console.log)

  // just render results
  autocannon.track(instance, {})

  // this is used to kill the instance on CTRL-C
  process.once('SIGINT', () => {
    instance.stop()
  })
}

module.exports = { runAutocannonScenario }
