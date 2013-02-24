about this site...
==================

i've built several personal websites over the years, each time learning some new lessons.
Here's the process which led to the site you see before you now.

The code is on github [here](http://github.com/echohead/echohead.org).

# requirements

i pictured in my head what the perfect interface to this thing would be, and laid out a few requirements which descibed that interface, each of which will be explained in more detail below:

* deploy with `git push`
* no editing of html/css directly
* language-appropriate syntax highlighting
* conveniences for development mode
* hackability
* tests
* monitoring

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
I've deployed changes several times even during the writing of this post.

# haml and sass
`todo`

# syntax highlighting
`todo`

# dev mode
`todo`

# hackability
`todo`

# monitoring
`todo`
