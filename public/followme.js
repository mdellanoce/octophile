$('.github-follow-button').click(function() {
  var href = $(this).attr('href'),
    user = href.substring(href.lastIndexOf('/') + 1),
    authorizeUrl = 'https://github.com/login/oauth/authorize',
    options = {
      client_id: '148718244dbf91ab58bc',
      scope: 'user',
      redirect_uri: 'http://localhost:4567/follow/' + user
    };
  window.open(authorizeUrl + '?' + $.param(options), 'github');
  return false;
});