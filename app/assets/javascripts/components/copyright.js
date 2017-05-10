$(document).on('turbolinks:load', function() {
  if (!document.querySelector('#copyright')) {
    return;
  }

  var changeStyle = function() {
    var viewHeight = $(window).height();
    var containerHeight = $('main').height();

    if (viewHeight - containerHeight < 200) {
      $('#copyright').removeClass('copyright-fixed');
      $('#copyright').addClass('copyright');

      // Move left while there is a aside
      if ($('aside').length) {
        asideWidth = $('aside').width();
        $('#copyright').css('left', -asideWidth / 2 + 'px');

      } else {
        $('#copyright').css('left', 'NULL');
      }

    } else {
      $('#copyright').removeClass('copyright');
      $('#copyright').addClass('copyright-fixed');
      $('#copyright').css('left', '');
    }
  }

  // When window size changed
  window.onresize = changeStyle;

  // Init
  changeStyle();
});
