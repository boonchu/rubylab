##### Ruby lab

* [Ruby on Rails](http://railsforzombies.org)

##### How to install Ruby on Rails

###### Ruby setup
[learning ruby first](http://tryruby.org/levels/1/challenges/0)

* install ruby
```
yum install -y ruby
```
* install gpg key and compares the signature (requires by rvm)
```
$ gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
gpg: keyring `/home/bigchoo/.gnupg/secring.gpg' created
gpg: requesting key D39DC0E3 from hkp server keys.gnupg.net
gpg: /home/bigchoo/.gnupg/trustdb.gpg: trustdb created
gpg: key D39DC0E3: public key "Michal Papis (RVM signing) <mpapis@gmail.com>" imported
gpg: no ultimately trusted keys found
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)

$ curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
gpg: key D39DC0E3: "Michal Papis (RVM signing) <mpapis@gmail.com>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1
```

* get most stable rvm version
```
curl -L get.rvm.io | bash -s stable
```
* hook up with shell environments for rvm access
```
source /home/bigchoo/.rvm/scripts/rvm
```

* install latest ruby 2.x
```
$ ruby --version
ruby 2.0.0p598 (2014-11-13) [x86_64-linux]
$ which ruby
/usr/bin/ruby
$ rvm list rubies
# No rvm rubies installed yet. Try 'rvm help install'.
$ rvm install 2.1.0
```

* verify latest ruby 2.x
```
$ rvm list rubies
rvm rubies
=* ruby-2.1.0 [ x86_64 ]
# => - current
# =* - current && default
#  * - default
$ ruby --version
ruby 2.1.0p0 (2013-12-25 revision 44422) [x86_64-linux]
```

##### RVM Gem Set

* [learning basic of gemset](https://rvm.io/gemsets/basics)

```
$ rvm use 2.1.0@myapp --create
ruby-2.1.0 - #gemset created /home/bigchoo/.rvm/gems/ruby-2.1.0@myapp
ruby-2.1.0 - #generating myapp wrappers..........
Using /home/bigchoo/.rvm/gems/ruby-2.1.0 with gemset myapp

$ rvm gemset (empty|delete) myapp

###### Ruby on Rails 
http://railsforzombies.org/
$ gem install rails
$ gem list --local rails

*** LOCAL GEMS ***

rails (4.2.0)
rails-deprecated_sanitizer (1.0.3)
rails-dom-testing (1.0.5)
rails-html-sanitizer (1.0.1)
sprockets-rails (2.2.4)
```


