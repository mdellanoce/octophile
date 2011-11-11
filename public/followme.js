(function(followUrl) {
  function getTarget(event) {
    var target = event.target || event.srcElement;
    if (target.nodeType == 3) {
      target = target.parentNode;
    }
    return target;
  };
  
  function preventDefault(event) {
    if (event.preventDefault) {
      event.preventDefault();
    }
    event.returnValue = false;
    return false;
  };
  
  function follow(event) {
    event = event || window.event;
    var target = getTarget(event),
      href = target.getAttribute('href'),
      user = href.substring(href.lastIndexOf('/') + 1);
    window.open(followUrl + '/' + user, 'followme', 'location=0,status=0,scrollbars=0,width=1000,height=450');
    return preventDefault(event);
  };

  var anchors = document.getElementsByTagName('a'),
    anchor, i, ii;
  
  for (i=0, ii=anchors.length; i<ii; i++) {
    anchor = anchors[i];
    if (anchor.className.indexOf('github-follow-button') >= 0) {
      if (anchor.addEventListener) {
        anchor.addEventListener('click', follow, false);
      } else if (anchor.attachEvent) {
        anchor.attachEvent('onclick', follow);
      }
    }
  }
})('http://localhost:4567/follow');