Fluxxor = require 'fluxxor'
constants = require './constants'

module.exports = TodoStore = Fluxxor.createStore
  initialize: () ->
    @todoId = 0
    @todos = {}

    @bindActions(
      constants.ADD_TODO, @onAddTodo,
      constants.TOGGLE_TODO, @onToggleTodo,
      constants.CLEAR_TODOS, @onClearTodos
    )

  onAddTodo: (payload) ->
    id = @_nextTodoId()
    todo =
      id: id
      text: payload.text
      complete: false

    @todos[id] = todo
    @emit 'change'

  onToggleTodo: (payload) ->
    id = payload.id
    @todos[id].complete = !@todos[id].complete
    @emit 'change'

  onClearTodos: () ->
    todos = @todos

    Object.keys(todos).forEach (key) ->
      if todos[key].complete
        delete todos[key]

    @emit 'change'

  getState: () ->
    todos: @todos

  _nextTodoId: () ->
    ++@todoId
