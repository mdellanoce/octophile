(function($) {
  $(':text,textarea').focus(function() {
    $(this).select();
  }).mouseup(function() {
    return false;
  });

  var username = $('#username'), user;
  setInterval(function() {
    if (user !== username.val()) {
      user = username.val();

      $('#html').val(
        '<a href="https://github.com/' + user + '" class="github-follow-button">Follow On GitHub</a>\n' +
        '<script type="text/javascript" src="http://octophile.com/widgets.js"></script>');

      $('iframe').attr('src', function(i, src) {
        return src.replace(/user=(.*)/, 'user=' + user);
      });
    }
  }, 250);
})(jQuery);
