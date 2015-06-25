t = require 'tcomb-form'
React = require 'react'
Router = require 'react-router'
RouteHandler = Router.RouteHandler
Link = Router.Link
Fluxxor = require 'fluxxor'
schema = require '../schema'

AddView = React.createClass
  mixins: [
    Fluxxor.FluxMixin React
  ]

  contextTypes:
    router: React.PropTypes.func

  render: () ->
    return @renderWithLayout(
      <div>
        <form onSubmit={@onSubmit}>
          <input type="submit" value="Save" />
        </form>
      </div>
    )

  renderWithLayout: (content) ->
    return (
      <div>
        {content}
        <hr />
        <Link to="home">Home</Link>
        {" | "}<Link to="add-item">Add New Item</Link>
      </div>
    )

  onSubmit: (e) ->
    e.preventDefault()

    newItem = @refs.form.getValue()
    if (newItem)
      console.log 'Add item'

  deleteItem: (e) ->
    if (confirm 'Really delete this recipe?')
      console.log 'Remove item'
    else
      e.preventDefault()

module.exports = AddView
