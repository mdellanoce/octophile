(function($) {
  $(':text,textarea').focus(function() {
    $(this).select();
  }).mouseup(function() {
    return false;
  });

  $('#username').keyup(function() {
    var user = $(this).val();
    $('#html').val(
      '<a href="https://github.com/' + user + '" class="github-follow-button">Follow On GitHub</a>\n' +
      '<script type="text/javascript" src="http://octophile.com/widgets.js"></script>');
  }).keyup();
})(jQuery);
