React = require 'react'
Router = require 'react-router'
Link = Router.Link
Fluxxor = require 'fluxxor'

ItemView = React.createClass
  mixins: [
    Fluxxor.FluxMixin(React)
  ]

  contextTypes:
    router: React.PropTypes.func

  getStateFromFlux: () ->
    args = @context.router.getCurrentParams()
    return item: {}

  componentWillReceiveProps: (nextProps) ->
    @setState @getStateFromFlux()

  render: () ->
    item = @state.item

    if (item == null)
      return @renderNotFound()

    description = (item.description or '').replace /\n/g, '<br />'

    return @renderWithLayout(
      <div>
        <h1>Item</h1>
        <p dangerouslySetInnerHTML={{__html: description}} />

        <p>
          <Link to="edit-item" params={{id: 1}}>Edit</Link>
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
      console.log 'Remove item'
    else
      e.preventDefault()

module.exports = ItemView
