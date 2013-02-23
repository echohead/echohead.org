makeshift notifications with gmail
==================================

Recently, I found myself wanting some long-running code running on a disposable cloud instance to be able to notify me when some conditions were met, and looked for the simplest approach that would work.

Shelling out to the `mail` utility seemed like an easy way to do this, but I didn't have a mail server handy which I could point this box to.

It turns out that it's pretty simple to hook up a gmail account with ssmtp so that email can be sent via the shell `mail` utility:

* grab a dedicated email address from gmail, say `notify.john.doe@gmail.com`

* install ssmtp, and put your gmail credentials in a config file:

```bash
sudo apt-get install -y ssmtp
cat > /etc/ssmtp/ssmtp.conf <<EOF
AuthUser=notify.john.doe@gmail.com
AuthPass=secret_password
FromLineOverride=YES
mailhub=smtp.gmail.com:587
UseSTARTTLS=YES
EOF
```

* now you can send mail from the shell:

```bash
echo "the mail body" | mail -s "the subject" me@example.com
```

* or by extension, from some code:

```ruby
def long_running_operation(params)
  if something_happened?
    `echo "alert!" | mail -s "that thing happened!" me@example.com`
  end
end
```
