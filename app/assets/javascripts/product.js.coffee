jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).closest('.field').remove()
    event.preventDefault()
