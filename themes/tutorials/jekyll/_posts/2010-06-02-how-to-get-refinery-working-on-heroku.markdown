---
layout: tutorial
title: How to get Refinery working on Heroku
description: 
  Heroku is a little bit trickier to get working on Refinery, this tutorial shows you how.
category: intermediate
author: Steven Heidel
---

This tutorial assumes that you know how to use Heroku and you've already got an app set up for use with Refinery.

## Step 1: Switch to S3 for storage

Refinery is often used on Heroku, so it's very easy to switch over the storage. Simply add/change one setting:

{% highlight ruby %}
Refinery.s3_backend = true
{% endhighlight %}

in your ``config/environments/production.rb`` file to make Refinery store files uploaded on Amazon S3.

## Step 2: Set up Amazon S3

__Skip this step if you never want to use images or resources__

Add your access key and secret key to the ``config/amazon_s3.yml`` file.

    login: &login
      access_key_id: [Your Access Key]
      secret_access_key: [Your Secret Access Key]

    ...

    production:
      bucket_name: [Bucket Name]
      <<: *login
      distribution_domain: [Bucket Name].s3.amazonaws.com

* All this information can be found by logging into your Amazon S3 account
* If you are using cloudfront you may subsitute that for the distribution domain

## Step 3: Sort out .gems

Make sure your gems are set correctly in the .gems file. Specifically, be certain that your refinerycms gem versions match.

Most of the time this should require no additional configuration.

## Step 4: Push to Heroku

    git push heroku master
    heroku rake db:setup

Hopefully all goes well, otherwise look at the troubleshooting section.

# Troubleshooting

### Missing a required gem

Simply add that gem to the .gems file

### Images or Resources don't work

Double check your ``config/amazon_s3.yml`` information

### Other problems?

Hop on to the [IRC Channel](irc://irc.freenode.net/refinerycms) and ask either stevenheidel or parndt for help. Otherwise, run ``heroku logs`` and see if you can spot the error yourself.
