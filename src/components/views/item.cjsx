React = require 'react'
Router = require 'react-router'
Link = Router.Link
Fluxxor = require 'fluxxor'

ItemView = React.createClass
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
    item = @state.item

    if !item
      return @renderNotFound()

    summary = (item.summary or '').replace /\n/g, '<br />'

    @renderWithLayout(
      <div>
        <h1>{item.title}</h1>
        <p dangerouslySetInnerHTML={{ __html: summary }} />

        <p>
          <Link to="edit-item" params={{id: @state.id}}>Edit</Link>
          {" | "}<Link to="home" onClick={@deleteItem}>Delete</Link>
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

  deleteItem: (e) ->
    if (confirm 'Really delete this item?')
      @getFlux().actions.project.remove @state.id
    else
      e.preventDefault()

module.exports = ItemView
