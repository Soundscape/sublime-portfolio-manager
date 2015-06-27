React = require 'react'
Router = require 'react-router'
Route = Router.Route
DefaultRoute = Router.DefaultRoute
views = require '../views'

routes = (
  <Route handler={views.project.EmptyView} name="home" path="/">
    <Route handler={views.project.AddView} name="add-item" path="/project/add" />

    <Route handler={views.project.EmptyView} path="/project/:id">
      <Route handler={views.project.EditView} name="edit-item" path="edit" />
      <DefaultRoute handler={views.project.ItemView} name="item" />
    </Route>

    <DefaultRoute handler={views.project.ListView} />
  </Route>
)

module.exports = routes
