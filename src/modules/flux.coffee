Fluxxor = require 'fluxxor'
stores = require './stores'
actions = require './actions'

flux = new Fluxxor.Flux stores, actions

flux.on 'dispatch', (type, payload) ->
  if console && console.log
    console.log '[Dispatch]', type, payload

module.exports = flux
