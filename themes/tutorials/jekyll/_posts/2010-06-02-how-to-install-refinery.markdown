---
layout: tutorial
title: How to Install Refinery
description: 
  This tutorial will walk you through installing refinery for the very first time
category: beginner
author: Philip Arndt
---

## Installing and Setting Up Refinery

### 1. Get the Refinery code

#### Install the Gem (recommended)

    gem install refinerycms
    refinery path/to/project

#### Or, clone Refinery's GIT repository (not recommended)

The git repository is where all of the changes are made when any new code is written or existing code is updated. For this reason it is often better to use the gem or to checkout a particular tag (the latest is usually considered the most stable). So unless you want to use the latest code, checkout the latest tag by replacing 0.9.X.XX below with the appropriate version:

    git clone git://github.com/resolve/refinerycms.git mynewsite.com
    cd ./mynewsite.com
    git checkout 0.9.X.XX
    git remote rm origin
    git remote add origin git@github.com:you/yournewsite.git
    mv ./config/database.yml.example ./config/database.yml

### 2. Configuration

#### __You can skip this entire step if you are using the gem.__

Firstly, edit ``config/database.yml`` to reflect your database server details.

Next you'll need to install bundler if you don't have it already:

    gem install bundler

Now you will need to make sure that you specify the correct database driver and web server.
The default choices are mysql and unicorn but to change them open up ``Gemfile`` which is in your application's root directory.
You'll see a section like this:

{% highlight ruby %}
# Specify the database driver as appropriate for your application (only one).
gem 'mysql', :require => 'mysql'
#gem 'sqlite3-ruby', :require => 'sqlite3'

# Specify your favourite web server (only one).
gem 'unicorn', :group => :development
#gem 'mongrel', :group => :development
{% endhighlight %}

To choose a different driver or web server just comment out the one we've pre-selected and uncomment or write the one you want instead.

After you have bundler and you've chosen your database driver and web server, you'll need to install the gems that Refinery depends on.
You can do this by running:

    bundle install

Next create your database and fill it with Refinery's default data:

    rake db:setup


### 3. Starting up your site

    ruby script/server

Now visit [http://localhost:3000](http://localhost:3000) and your Refinery site should be running.

You will be prompted to setup your first user.

