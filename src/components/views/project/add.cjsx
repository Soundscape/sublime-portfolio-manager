t = require 'tcomb-form'
React = require 'react'
Router = require 'react-router'
RouteHandler = Router.RouteHandler
Link = Router.Link
Fluxxor = require 'fluxxor'
schema = require '../../schema'
forms = require '../../forms'

AddView = React.createClass
  mixins: [
    Fluxxor.FluxMixin React
  ]

  contextTypes:
    router: React.PropTypes.func

  render: () ->
    return @renderWithLayout(
      <div className="row">
        <div className="col s12">
          <h4>Add project</h4>
          <form onSubmit={@onSubmit}>
            <t.form.Form ref="form" type={schema.Project} options={forms.Project} />
            <button className="waves-effect waves-light btn" type="submit">
              Save
              <i className="material-icons right">save</i>
            </button>
          </form>
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
              <li><Link className="btn-floating red waves-effect waves-light" to="home"><i className="material-icons">home</i></Link></li>
            </ul>
          </div>
        </div>
      </div>
    )

  onSubmit: (e) ->
    e.preventDefault()

    newItem = @refs.form.getValue()
    if (newItem)
      @getFlux().actions.project.add newItem
      @getFlux().actions.route.transition '/'

module.exports = AddView
