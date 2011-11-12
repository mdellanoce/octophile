This project provides Twitter-style follow buttons for GitHub that you can place on your personal blog... or anywhere you want, really.

# Running the app

Install the dependencies:

```
bundle install
```

You will need to register an application with GitHub at https://github.com/account/applications/4227
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
