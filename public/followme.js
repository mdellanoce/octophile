(function(followUrl) {
  var anchors = document.getElementsByTagName('a'),
    anchor, i, ii, parent, iframe, user, href;
  
  for (i=0, ii=anchors.length; i<ii; i++) {
    anchor = anchors[i];
    if (anchor.className.indexOf('github-follow-button') >= 0) {
      href = anchor.getAttribute('href');
      user = href.substring(href.lastIndexOf('/') + 1);
      parent = anchor.parentNode;
      parent.removeChild(anchor);
      
      iframe = document.createElement('iframe');
      iframe.setAttribute('src', followUrl + '#user=' + user);
      iframe.setAttribute('allowtransparency', 'true');
      iframe.setAttribute('frameborder', '0');
      iframe.setAttribute('scrolling', 'no');
      parent.appendChild(iframe);
    }
  }
})('http://localhost:4567/follow_button.html');