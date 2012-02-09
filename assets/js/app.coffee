$ ->
  $('.add_new_tip_link').click (event) ->
    event.preventDefault()
    $('body').load('/assets/js/app.coffee')
