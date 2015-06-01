React = require 'react'

module.exports = TodoItem = React.createClass
  mixins: [window.FluxMixin]

  propTypes:
    todo: React.PropTypes.object.isRequired

  render: () ->
    style =
      textDecoration: if @props.todo.complete then "line-through" else ""

    return <span style={style} onClick={@onClick}>{@props.todo.text}</span>

  onClick: () ->
    window.flux.actions.toggleTodo(@props.todo.id)
