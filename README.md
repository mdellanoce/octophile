This project provides Twitter-style follow buttons for GitHub that you can place on your personal site... or anywhere you want, really.

# Using the button

Place the following on your webpage where you want the button to appear:

```html
<a href="https://github.com/YOURUSERNAME" class="github-follow-button">Follow Me On GitHub</a>
<script type="text/javascript" src="http://octophile.com/widgets.js"></script>
```

You can put as many anchor tags as you want on a given page, even with different usernames.
You only need to include the script once, but it must come after all of the buttons on the page.

# Running the app

Install the dependencies:

```
bundle install
```

You will need to [register an application with GitHub](https://github.com/account/applications/new).
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

# Deploying the app

Optimize the static files:

```
rake
```

This will copy all of the static content in the public folder to a folder named dist.
All of the javascript files will be minified. Javascript, CSS, and image files needed
by the follow button iframe will be bundled into the iframe's HTML.

Make sure the app is run in the production environment so that the optimized files
get used. To test that this works:

```
rackup -p 8080 -E production
```
