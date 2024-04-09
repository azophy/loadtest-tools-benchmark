'use strict'

const path = require('path')
const { runAutocannonScenario } = require('./base.js')

// generate random query params for each query
// see: https://github.com/mcollina/autocannon/blob/master/samples/request-context-workers.js
runAutocannonScenario([
  {
    method: 'GET',
    setupRequest: path.join(__dirname, 'dynamic-setup-request')
  },
  {
    method: 'POST',
    setupRequest: path.join(__dirname, 'dynamic-setup-request')
  },
], '/test/autocannon/dynamic-singlereq')
