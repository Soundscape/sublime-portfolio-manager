Fluxxor = require 'fluxxor'
stores = require './stores'
actions = require './actions'

flux = new Fluxxor.Flux stores, actions.methods

flux.on 'dispatch', (type, payload) ->
  console.log 'Dispatch:', type, payload

module.exports = flux
