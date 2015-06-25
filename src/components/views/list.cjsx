React = require 'react'
Router = require 'react-router'
RouteHandler = Router.RouteHandler
Link = Router.Link
Fluxxor = require 'fluxxor'

ListView = React.createClass
  mixins: [
    Fluxxor.FluxMixin React
  ]

  getInitialState: () ->
    return items: [{ id: 1 },{ id: 2 }]

  getStateFromFlux: () ->
    return items: [{ id: 1 },{ id: 2 }]

  render: () ->
    return (
      <div>
        <h1>Items</h1>
        <ul>{@state.items.map @renderItemLink}</ul>
        <div>
          <Link to="add-item">Add New Item</Link>
        </div>
      </div>
    )

  renderItemLink: (item) ->
    return (
      <li key={item.id}>
        <Link to="item" params={{id: item.id}}>Item</Link>
      </li>
    )

module.exports = ListView
