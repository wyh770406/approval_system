$(document).on('turbolinks:load', function() {
  var container = document.querySelector('.page-sidebar');
  if (!container) {
    return;
  }

  //$(container).perfectScrollbar();

  var $sidebar = $('.page-sidebar .sidebar');

  $sidebar.on('click', 'a', function(event){
    // 有二级菜单的一级菜单
    if (this.parentNode.classList.contains('treeview')) {
      event.preventDefault();
      event.stopPropagation();

      var tree = this.parentNode;
      var $menu = $(tree.querySelector('.treeview-menu'));

      tree.classList.toggle('active');
      $menu.slideToggle();
    }
    else {
      $sidebar.find('.current').removeClass('current');
      this.parentNode.classList.add('current');
    }
  });
});
