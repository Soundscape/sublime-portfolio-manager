React = require 'react'
Router = require 'react-router'
Route = Router.Route
DefaultRoute = Router.DefaultRoute
views = require '../views'

routes = (
  <Route handler={views.EmptyView} name="home" path="/">
    <Route handler={views.AddView} name="add-item" path="/item/add" />

    <Route handler={views.EmptyView} path="/item/:id">
      <Route handler={views.EditView} name="edit-item" path="edit" />
      <DefaultRoute handler={views.ItemView} name="item" />
    </Route>

    <DefaultRoute handler={views.ListView} />
  </Route>
)

module.exports = routes
