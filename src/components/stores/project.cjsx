Fluxxor = require 'fluxxor'
Net = require 'sublime-net'
actions = require '../actions'

ProjectStore = Fluxxor.createStore
  initialize: (options) ->
    @db = new Net.Firebase 'https://sublime-dev.firebaseio.com/'
    @items = {}
    @id = null

    @bindActions(
      actions.constants.PROJECT.FETCH, @fetch
      actions.constants.PROJECT.ADD, @add
      actions.constants.PROJECT.EDIT, @edit
      actions.constants.PROJECT.REMOVE, @remove
    )

    @fetch()

  fetch: () ->
    @db.query('project').on 'value', (s) =>
      @items = s.val()
      @emit 'change'

  add: (payload) ->
    @db.push('project', payload).on 'value', (s) =>
      console.log s, s.val()
      @emit 'change'

  edit: (payload) ->
    @db.update("project/#{payload.id}", payload.item)
    @emit 'change'

  remove: (payload) ->
    @db.remove("project/#{payload.id}")
    @emit 'change'

module.exports = ProjectStore
