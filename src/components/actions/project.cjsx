constants = require './constants'

module.exports =
  add: (item) ->
    @dispatch constants.PROJECT.ADD, item

  edit: (id, item) ->
    @dispatch constants.PROJECT.EDIT,
      id: id
      item: item

  remove: (id) ->
    @dispatch constants.PROJECT.REMOVE,
      id: id

  fetch: () ->
    @dispatch constants.PROJECT.FETCH
