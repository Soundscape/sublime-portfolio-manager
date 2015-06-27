React = require 'react'
Router = require 'react-router'
RouteHandler = Router.RouteHandler

module.exports = EmptyView = React.createClass
  render: () ->
    <RouteHandler {...this.props} />
