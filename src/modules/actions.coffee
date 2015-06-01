constants = require './constants'

module.exports =
  addTodo: (text) ->
    @dispatch constants.ADD_TODO, text: text

  toggleTodo: (id) ->
    @dispatch constants.TOGGLE_TODO, id: id

  clearTodos: () ->
    @dispatch constants.CLEAR_TODOS
