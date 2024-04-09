'use strict'

const { runAutocannonScenario } = require('./base.js')

runAutocannonScenario([
  {
    method: 'GET',
    path: '/test/autocannon/static-singlereq',
  },
])
