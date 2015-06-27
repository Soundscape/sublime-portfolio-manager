t = require 'tcomb-form'
React = require 'react'
Router = require 'react-router'
RouteHandler = Router.RouteHandler
Link = Router.Link
Fluxxor = require 'fluxxor'
forms = require '../forms'
schema = require '../schema'
stores = require '../stores'

EditView = React.createClass
  mixins: [
    Fluxxor.FluxMixin React
    Fluxxor.StoreWatchMixin 'project'
  ]

  contextTypes:
    router: React.PropTypes.func

  getStateFromFlux: () ->
    args = @context.router.getCurrentParams()
    store = @getFlux().store 'project'

    item: store.items[args.id]
    id: args.id

  componentWillReceiveProps: (nextProps) ->
    @setState @getStateFromFlux()

  render: () ->
    item = @state.item;

    if !item
      return @renderNotFound()

    @renderWithLayout(
      <div>
        <form onSubmit={@onSubmit}>
          <t.form.Form ref="form" type={schema.Project} options={forms.Project} value={item} />
          <input type="submit" value="Save" />
        </form>

        <p>
          <Link to="home" onClick={@deleteItem}>Delete Item</Link>
        </p>
      </div>
    )

  renderNotFound: () ->
    @renderWithLayout(
      <div>That item was not found.</div>
    )

  renderWithLayout: (content) ->
    (
      <div>
        {content}
        <hr />
        <Link to="home">Home</Link>
        {" | "}<Link to="add-item">Add New Item</Link>
      </div>
    )

  onSubmit: (e) ->
    e.preventDefault()

    item = @refs.form.getValue()
    if (item)
      @getFlux().actions.project.edit @state.id, item
      @context.router.transitionTo 'item', id: @state.id

  deleteItem: (e) ->
    if (confirm 'Really delete this item?')
      @getFlux().actions.project.remove @state.id
    else
      e.preventDefault()

module.exports = EditView
