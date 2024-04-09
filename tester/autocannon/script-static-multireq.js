'use strict'

const { runAutocannonScenario, randomString } = require('./base.js')

// [<id>] will be replaced with generated HyperID at run time
// see:
runAutocannonScenario([
  {
    method: 'GET',
    path: '/test/autocannon/static-multireq',
  },
  {
    method: 'POST',
    path: '/test/autocannon/static-multireq',
  },
])
