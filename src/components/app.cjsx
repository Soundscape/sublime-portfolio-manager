React = require 'react'
Application = require './application'
flux = require '../modules/flux'

React.render <Application flux={flux} />, document.getElementById 'content'
