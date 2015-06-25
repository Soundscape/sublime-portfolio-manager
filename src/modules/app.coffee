$ = require 'jquery'
require 'materialize'
require '../components'

$ () ->
  $('.button-collapse').sideNav closeOnClick: true
  $('.parallax').parallax()
  $('.modal-trigger').leanModal()
  $('.scrollspy').scrollSpy()
  options = [
    #{ selector: '#projects', offset: 50, callback: 'Materialize.toast("This is our ScrollFire Demo!", 1500 )' }
  ];

  Materialize.scrollFire options
