$(document).on('turbolinks:load', function() {
  var defaultOptions = {
    title: '请确认',
    body: '',
    cancleClass: 'btn-default',
    cancleText: '取消',
    confirmClass: 'btn-primary',
    confirmText: '确认',
    cancled: null,
    confirmed: null,
    backdrop: true
  };

  var template = $('\
    <div class="modal fade" tabindex="-1">\
      <div class="modal-dialog">\
        <div class="modal-content">\
          <div class="modal-header">\
            <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>\
            <h4 class="modal-title"></h4>\
          </div>\
          <div class="modal-body">\
          </div>\
          <div class="modal-footer">\
            <button type="button" class="btn confirm ladda-button" data-style="zoom-in"></button>\
            <button type="button" class="btn cancle ladda-button" data-style="zoom-in"></button>\
          </div>\
        </div>\
      </div>\
    </div>\
  ');

  this.Confirm = function(options){
    var modal, confirmBtnLadda, cancleBtnLadda, closeModal;
    if (!$.isPlainObject(options)) {
      return;
    }

    options = $.extend({}, defaultOptions, options);
    modal = template.clone();
    modal.find('.modal-title').text(options.title);
    modal.find('.modal-body').text(options.body);
    modal.find('.cancle').addClass(options.cancleClass).text(options.cancleText);
    modal.find('.confirm').addClass(options.confirmClass).text(options.confirmText);

    modal.appendTo(document.body);
    modal.modal('show');

    confirmBtnLadda = Ladda.create(modal.find('.confirm')[0]);
    cancleBtnLadda = Ladda.create(modal.find('.cancle')[0]);

    closeModal = function(){
      confirmBtnLadda.stop();
      cancleBtnLadda.stop();
      modal.modal('hide');
    };

    modal.find('.confirm').on('click', function(){
      if ($.isFunction(options.confirmed)) {
        confirmBtnLadda.start();
        options.confirmed(closeModal);
      } else {
        closeModal();
      }
    });

    modal.find('.cancle').on('click', function(){
      if ($.isFunction(options.cancled)) {
        cancleBtnLadda.start();
        options.cancled(closeModal);
      } else {
        closeModal();
      }
    });

    modal.on('hidden.bs.modal', function(){
      modal.remove();
    });
  };
}());
