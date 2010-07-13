---
layout: tutorial
title: How to Add Image Gallery to Pages
description: 
  This tutorial is going to teach you how to implement image gallery in pages with portfolio plugin.
category: intermediate
author: Peter Zlatnar
---
In this tutorial I will show you how to implement gallery with portfolio plugin in few simple steps. Solution is quick and dirty, but despite that I hope you will find something helpful. Tutorial assumes that you have already portfolio plugin installed and created a few entries.

Most of the work is done in pages plugin folder ``/vendor/plugins/pages`` except for javascript which is done in `/public/javascripts` folder. Be aware I will be missing out ``/vendor/plugins/pages`` path for the most of the time.

## Preview
![alt text](../images/page_gallery.jpg "Page gallery")

## Step 1: Create association between page and portfolio entry

Let say we want every page has exactly one gallery. So for achieve that we are going to add association in page model. Add following code in ``/app/models/page.rb``

    belongs_to :gallery, :class_name => "PortfolioEntry", :foreign_key => :portfolio_entry_id

Next we have to add foreign key attribute to the pages table. Just run following migration:

    class AddPortfolioEntrieToPages < ActiveRecord::Migration
      def self.up
        add_column :pages, :portfolio_entry_id, :integer
      end

      def self.down
        remove_column :pages, :portfolio_entry_id
      end
    end

## Step 2: Add select gallery option in page form

First we want to select gallery from list of options ( add a few entries in portfolio plugin ). Insert this code in ``/app/views/admin/pages/_form.html.erb``

    <div class="field images_field">
      <%= f.label 'Select Gallery' %>
      <%= f.select (:portfolio_entry_id, PortfolioEntry.all.collect { |p| [p.title, p.id.to_s] }, { 
                    :prompt   => 'Select gallery', 
                    :selected =>  @page.portfolio_entry_id.to_s }, 
                    :class    => 'select_gallery' ) %>

      <%= render :partial => 'gallery', :locals => { :f => f, :gallery => @page.gallery } %>
    </div>

Because we are lazy we are going to use stylesheet from portfolio plugin. Insert below code in ``/app/views/admin/pages/_form.html.erb``

    <% content_for :head do %>
      <%= stylesheet_link_tag 'portfolio' %>
    <% end %>

Next we have to create partial called gallery in ``/app/views/admin/pages/``

    <div class="gallery_placeholder">
      <ul id='portfolio_images' class='clearfix portfolio_entry_images'>
        <% unless gallery.blank? %>
          <% gallery.images.each do |image| %>
            <li id='image_<%= image.id %>'>
              <%= image_fu image, :grid %>
            </li>
          <% end %>
        <% end %>
      </ul>
    </div>

Now you should be able to attach image gallery from portfolio to the page. Accessing gallery should be easy as that:

    # Retrieve page gallery
    @page.gallery
    # Retrieve all images from gallery
    @page.gallery.images

## Step 3: Add some ajax magick

For now we could just select gallery from dop down without actually see which images contains. But we want to see images so we will fix that right away. First add this javascript function in ``/public/javascripts/admin.js`` file:

    init_gallery = function () {
      var gallery_placeholder = $('.gallery_placeholder');
      var portfolio_entry     = $('#page_portfolio_entry_id');
      var error_text          = '<p>Some error message.</p>';

      $('.select_gallery').change(function(e) {
        $('#portfolio_images').remove();

        gallery_placeholder.empty().html('<img src="/images/refinery/ajax-loader.gif" style="padding:10px 0;">');

        $.ajax({
          type: 'GET',
          url: '/refinery/load_gallery',
          dataType: 'xml/html/script/json',
          data: ({id : portfolio_entry.val() }),
          success: function (data) {
            gallery_placeholder.empty();
            $(data).appendTo(gallery_placeholder);
          },
          error: function () {
            gallery_placeholder.empty().append(error_text);
          }
        });
        e.preventDefault();
      });
    }

and call it in document ready block:

    $(document).ready(function(){
      init_gallery();
    });

In above function we call ``load_gallery`` action which returns images for selected gallery. So we need to add this action in ``/app/controllers/admin/pages_controller.rb``. Lets do it:

    def load_gallery
      @portfolio_entry = PortfolioEntry.find(params[:id])
      if request.xhr? and params[:id]
        render :partial => 'gallery', :locals => {:gallery => @portfolio_entry }
      else
        render :text => 'No params was sent!'
      end
    end

But this would not work until we added below route in ``/config/routes.rb``

    map.namespace(:admin, :path_prefix => 'refinery') do |admin|
      admin.load_gallery "/load_gallery", :controller => "pages", :action => "load_gallery"
    end

Now you should be able to bind portfolio entries on every single page and preview images on select action.