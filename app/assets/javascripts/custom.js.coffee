jQuery(document).ready ($) ->
  $('.clickable-row').click ->
    window.document.location = $(this).data('href')
    return
  return
