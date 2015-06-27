React = require 'react'
Router = require 'react-router'
RouteHandler = Router.RouteHandler
Link = Router.Link
Fluxxor = require 'fluxxor'

ListView = React.createClass
  mixins: [
    Fluxxor.FluxMixin React
    Fluxxor.StoreWatchMixin 'project'
  ]

  getStateFromFlux: () ->
    store = @getFlux().store 'project'

    items: store.items
    id: store.id

  render: () ->
    keys = Object.getOwnPropertyNames @state.items

    (
      <div>
        <h1>Items</h1>
        <ul>{keys.map @renderItemLink}</ul>
        <div>
          <Link to="add-item">Add New Item</Link>
        </div>
      </div>
    )

  renderItemLink: (id) ->
    item = @state.items[id]

    (
      <li key={id}>
        <Link to="item" params={{id: id}}>{item.title}</Link>
      </li>
    )

module.exports = ListView
