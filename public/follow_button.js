(function() {
  var kv, hash = {}, pairs = (location.hash == "" ? location.search : location.hash).substring(1).split('&');
  for (var i=0,ii=pairs.length; i<ii; i++) {
    kv = pairs[i].split('=');
    hash[kv[0]] = kv[1];
  }
  
  var b = document.getElementById('follow-button'),
    p = document.getElementById('profile-link'),
    user = hash['user'],
    follow = function() {
      window.open('/follow/' + user, 'followme', 'location=0,status=0,scrollbars=0,width=1000,height=450');
    };
  
  b.setAttribute('title', 'Follow ' + user + ' on GitHub');
  
  if (b.addEventListener) {
    b.addEventListener('click', follow, false);
    p.addEventListener('click', follow, false);
  } else if (b.attachEvent) {
    b.attachEvent('onclick', follow);
    p.attachEvent('onclick', follow);
  }
})();
