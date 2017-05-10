$(document).on('turbolinks:load', function() {
  var flash = $("#flash");
  if (flash.length > 0) {
    flashPrompt(flash.text())
  }
});
