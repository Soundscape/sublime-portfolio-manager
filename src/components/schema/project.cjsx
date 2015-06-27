t = require 'tcomb-form'

module.exports = t.struct
  title: t.Str
  summary: t.Str
  repo: t.Str
  user: t.Str
