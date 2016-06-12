ready = ->
  $('.button-collapse').sideNav()
  $('.parallax').parallax()

$(document).ready(ready)
$(document).on('page:load', ready)