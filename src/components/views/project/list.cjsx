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
      <div className="row">
        <div className="col s12">
          <div className="collection with-header">
            <div className="collection-header"><h4>Projects</h4></div>
            {keys.map @renderItemLink}
          </div>
          <div className="fixed-action-btn" style={bottom: '45px', right: '24px'}>
            <a className="btn-floating btn-large red">
              <i className="large material-icons">more_vert</i>
            </a>
            <ul>
              <li><Link className="btn-floating blue waves-effect waves-light" to="add-item" style={marginRight: '.5em'}><i className="material-icons">add</i></Link></li>
            </ul>
          </div>
        </div>
      </div>
    )

  renderItemLink: (id) ->
    item = @state.items[id]

    (
      <Link className="collection-item" key={id} to="item" params={{id: id}}>{item.title}</Link>
    )

module.exports = ListView
