constants = require './constants'

module.exports =
  transition: (path, args) ->
    @dispatch constants.ROUTE.TRANSITION,
      path: path
      args: args
