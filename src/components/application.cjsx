React = require 'react'
Fluxxor = require 'fluxxor'
TodoItem = require './todo.item'

window.FluxMixin = FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin;

module.exports = Application = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("TodoStore")]

  getInitialState: () ->
    newTodoText: ""

  getStateFromFlux: () ->
    flux = @getFlux()
    flux.store("TodoStore").getState()

  render: () ->
    todos = @state.todos
    return (
      <div>
        <ul>
          {Object.keys(todos).map (id) ->
            return <li key={id}><TodoItem todo={todos[id]} /></li>
          }
        </ul>
        <form onSubmit={@onSubmitForm}>
          <input type="text" size="30" placeholder="New Todo"
                 value={@state.newTodoText}
                 onChange={@handleTodoTextChange} />
          <button type="submit" className="btn waves-effect waves-light">Add Todo</button>
        </form>
        <button onClick={@clearCompletedTodos} className="btn waves-effect waves-light">Clear Completed</button>
      </div>
    )

  handleTodoTextChange: (e) ->
    @setState newTodoText: e.target.value

  onSubmitForm: (e) ->
    e.preventDefault()
    if @state.newTodoText.trim()
      @getFlux().actions.addTodo(@state.newTodoText)
      @setState(newTodoText: "")

  clearCompletedTodos: (e) ->
    @getFlux().actions.clearTodos()
