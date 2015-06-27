RouteStore = require './route'
ProjectStore = require './project'

module.exports =
  route: new RouteStore()
  project: new ProjectStore()
