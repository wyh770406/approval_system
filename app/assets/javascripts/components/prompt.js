// 消息提示，渐现渐隐
this.flashPrompt = function(message){
  var node = document.createElement('div');
  node.className = 'flash-prompt'
  node.innerHTML = '<span>' + message + '</span>'

  var listener = function(){
    this.remove();
  }

  if ('onanimationend' in node){
    node.addEventListener('animationend', listener);
  }
  else {
    node.addEventListener('webkitAnimationEnd', listener);
    node.addEventListener('MSAnimationEnd', listener);
    node.addEventListener('oAnimationEnd', listener);
  }

  document.body.appendChild(node);
};
