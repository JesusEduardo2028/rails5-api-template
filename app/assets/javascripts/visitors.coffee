ready = ->
  $('.button-collapse').sideNav()
  $('.parallax').parallax()
  $('.vanish').delay(5000).fadeOut(1000)
  $(document).on 'click','.vanish', ->
    $('.vanish').fadeOut(1000)
$(document).ready(ready)
$(document).on('page:load', ready)