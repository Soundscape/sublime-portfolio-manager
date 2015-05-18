React = require 'react'

module.exports = Sample = React.createClass
  render: () ->
    <div className="sample-component">
      <h1>
        My sample component
      </h1>
      <hr />
      {<p key={n}>This line has been printed {n} times</p> for n in [1..5]}
    </div>
