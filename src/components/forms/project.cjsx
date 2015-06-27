React = require 'react'
t = require 'tcomb-form'
schema = require '../schema'
Project = schema.Project

struct = (locals)  ->
  inputs = locals.inputs

  return (
    <fieldset className="form-struct project">
      <div className="form-row title">
        {inputs.title}
      </div>
      <div className="form-row user">
        {inputs.user}
      </div>
      <div className="form-row repo">
        {inputs.repo}
      </div>
      <div className="form-row summary">
        {inputs.summary}
      </div>
    </fieldset>
  )

module.exports =
  auto: 'none'
  templates:
    struct: struct

  fields:
    title:
      label: 'Title'
      attrs:
        required: true
        validate: true
        name: 'title'
    user:
      label: 'User'
      attrs:
        required: true
        validate: true
        name: 'user'
    repo:
      label: 'Repository'
      attrs:
        required: true
        validate: true
        name: 'repo'
    summary:
      type: 'textarea'
      label: 'Summary'
      attrs:
        required: true
        validate: true
        name: 'summary'
