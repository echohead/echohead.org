about this site...
==================

i've built several personal websites over the years, each time learning some new lessons.
Here's the process which led to the site you see before you now.

The code is on github [here](http://github.com/echohead/echohead.org).

# requirements

i pictured in my head what the perfect interface to this thing would be, and laid out a few requirements which descibed that interface, each of which will be explained in more detail below:

* deploy with `git push`
* run in a fast, reliable webserver
* hackability
* tests
* monitoring
* language-appropriate syntax highlighting
* no editing of html/css directly

# deploying with `git push`
As a developer, git is already constantly at my fingertips, so why not use it for deployment?
This approach has several advantages:

* any change that goes to production is by definition in source control.
* rollbacks are simple.
* every change gets checked in anyway, so why have additional steps?

So how does one hook up automagical `git push` deployments? Here is one way:

1. Write a shell script which updates your service from git and restarts it, something like this:

```bash
# bin/update
cd $svc_dir && git pull && $svc_dir/bin/restart
```

2. Add a hook in your app to call the update script:

```ruby
post '/__push_notification__' do
  # check that you actually want to deploy this commit
  if push_looks_legit? params[:payload]
    fork do
      exec update_script_path
    end
  end
end
```

3. Call your hook from a post-commit hook. On github, just add your url as a 'webhook' in project settings:

```
http://yourdomainname/__push_notification__
```

Now, deployments are as simple as `git push origin master`, and go live within about 5 seconds!
I've casually deployed changes several times during the writing of this post.



# the webserver

I wanted to run this whole thing inside a webserver setup which is fast and reliable.
For this, I chose [unicorn][unicorn] behind [nginx][nginx].  Nginx handles buffering requests, and multiple unicorn processes serve them on a first-free basis.  The number of unicorn processes can be easily scaled up or down dynamically by sending signals to the main unicorn process.  New worker processes can overlap with old ones to allow zero-downtime service restarts.




# hackability

Every development convenience is provided for:

Start a local dev server, which reloads source files on every request (using [shotgun][shotgun]):

```bash
rake
```

Watch SASS files and re-compile whenever they are changed:

```
rake sass
```

Add some new experimental interactive route to the site:

```ruby
get '/sandbox' do
  # do crazy stuff here
end
```

Test EVERYTHING:

```ruby
describe 'about_this_site' do
  get '/about_this_site/'.body.should =~ /body.should/
end
```

# monitoring
`todo`

# syntax highlighting

Glorify makes this _way too easy_:

```ruby
require 'glorify'
Tilt.prefer Sinatra::Glorify::Template
```

[unicorn]: https://github.com/defunkt/unicorn
[nginx]: http://wiki.nginx.org/Main
[shotgun]: https://github.com/rtomayko/shotgun
