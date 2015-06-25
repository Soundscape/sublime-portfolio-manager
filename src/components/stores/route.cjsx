Fluxxor = require 'fluxxor'
actions = require '../actions'
router = require('../routes').router

RouteStore = Fluxxor.createStore
  initialize: (options) ->
    @bindActions(
      actions.constants.ROUTE.TRANSITION, @handleRouteTransition
    )

  handleRouteTransition: (payload) ->
    path = payload.path
    args = payload.args

    router.transitionTo path, args

module.exports = RouteStore
