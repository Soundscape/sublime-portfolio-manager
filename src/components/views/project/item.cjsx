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
      <div className="row">
        <div className="col s12">
          <h4>{item.title}</h4>
          <p className="flow-text" dangerouslySetInnerHTML={__html: summary} />
        </div>
      </div>
    )

  renderNotFound: () ->
    return @renderWithLayout(
      <div className="row">
        <div className="col s12">
          <p className="flow-text">That item was not found.</p>
        </div>
      </div>
    )

  renderWithLayout: (content) ->
    return (
      <div className="row">
        <div className="col s12">
          {content}
          <div className="fixed-action-btn" style={bottom: '45px', right: '24px'}>
            <a className="btn-floating btn-large red">
              <i className="large material-icons">more_vert</i>
            </a>
            <ul>
              <li><Link className="btn-floating green waves-effect waves-light" to="home" style={marginRight: '.5em'}><i className="material-icons">home</i></Link></li>
              <li><Link className="btn-floating yellow darken-1 waves-effect waves-light" to="edit-item" params={id: @state.id} style={marginRight: '.5em'}><i className="material-icons">edit</i></Link></li>
              <li><Link className="btn-floating blue waves-effect waves-light" to="add-item" style={marginRight: '.5em'}><i className="material-icons">add</i></Link></li>
              <li><Link className="btn-floating red waves-effect waves-light" to="home" onClick={@deleteItem} style={marginRight: '.5em'}><i className="material-icons">delete</i></Link></li>
            </ul>
          </div>
        </div>
      </div>
    )

  deleteItem: (e) ->
    if (confirm 'Really delete this item?')
      @getFlux().actions.project.remove @state.id
    else
      e.preventDefault()

module.exports = ItemView
