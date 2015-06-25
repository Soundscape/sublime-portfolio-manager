React = require 'react'
flux = require './flux'
router = require('./routes').router

router.run (Handler) ->
  React.render(
    <Handler flux={flux} />,
    document.getElementById 'content'
  )
