This project provides Twitter-style follow buttons for GitHub that you can place on your personal blog... or anywhere you want, really.

# Using the button

Place the following on your webpage where you want the button to appear:

```html
<a href="https://github.com/YOURUSERNAME" class="github-follow-button">Follow Me On GitHub</a>
<script type="text/javascript" src="http://followme.mikedellanoce.com/followme.js"></script>
```

You can put as many anchor tags as you want on a given page, even with different usernames.
You only need to include the script once, but it must come after all of the buttons on the page.

# Running the app

Install the dependencies:

```
bundle install
```

You will need to register an application with GitHub at https://github.com/account/applications/new.
Set your client ID and client secret in your .bashrc or .bash_profile (or equivalents for whichever shell you use):

```
export GITHUB_CLIENT_ID=???
export GITHUB_CLIENT_SECRET=???
```

Run the app:

```
rackup -p 8080
```

Browse to http://localhost:8080
