# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
window.Depot ||= {}
$ ->
  Depot.cart_show = ->
    $('#cart').show('drop', 1000)
  Depot.cart_hide = (after_handler = ->) ->
    $('#cart').hide('drop', 500, after_handler)