t = require 'tcomb-form'
React = require 'react'
Router = require 'react-router'
RouteHandler = Router.RouteHandler
Link = Router.Link
Fluxxor = require 'fluxxor'

schema = require '../schema'
stores = require '../stores'

EditView = React.createClass
  mixins: [
    Fluxxor.FluxMixin React
  ]

  contextTypes:
    router: React.PropTypes.func

  getStateFromFlux: () ->
    args = @context.router.getCurrentParams()
    return item: {}

  componentWillReceiveProps: (nextProps) ->
    @setState @getStateFromFlux()

  render: () ->
    item = @state.item;

    if (item == null)
      return @renderNotFound()

    return @renderWithLayout(
      <div>
        <form onSubmit={@onSubmit}>
          <input type="submit" value="Save" />
        </form>

        <p>
          <Link to="home" onClick={deleteItem}>Delete Item</Link>
        </p>
      </div>
    )

  renderNotFound: () ->
    return @renderWithLayout(
      <div>That item was not found.</div>
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
      console.log 'Edit item'
      @context.router.transitionTo 'item', id: 1

  deleteItem: (e) ->
    if (confirm 'Really delete this item?')
      console.log 'Remove item'
    else
      e.preventDefault()

module.exports = EditView
