$(document).on('turbolinks:load', function() {
  ///
  // Ujs submit
  //
  // [Usage]
  //
  // <button data-submit-id="order-form"></button>
  // <form id="order-form">...</form>
  //
  $('[data-submit-id]').click(function(event) {
    event.preventDefault();

    form = '#' + $(this).data('submit-id');
    // Get where the submit is from
    $(form).append('<input type="hidden" name="submit_from" value="' + ( $(this).data('submit-from') || $(this).val() )  + '" /> ');
    $(form).submit();
  });
})
