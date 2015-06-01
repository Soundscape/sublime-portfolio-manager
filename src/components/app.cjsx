React = require 'react'
Fluxxor = require 'fluxxor'
stores = require '../modules/stores'
actions = require '../modules/actions'
Application = require './application'

window.flux = flux = new Fluxxor.Flux stores, actions

flux.on 'dispatch', (type, payload) ->
  if console && console.log
    console.log '[Dispatch]', type, payload

React.render <Application flux={flux} />, document.getElementById 'content'
