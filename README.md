jQuery Infinite Pages
=====================
Installation
------------

Add these line to your application's `Gemfile`:
```ruby
gem 'jquery-infinite-pages'
gem 'kaminari', '~> 0.16.3'
```

And then execute:
```
bundle install
```

Check to make sure the following has been added to your `application.js` file:
```javascript
//= require jquery.infinite-pages
```

Rails/Kaminari Example
----------------------

The following is an example of how to integrate this plugin into your Rails app
using Kaminari.

Set up pagination in `posts_controller.rb`:

```ruby
class PostsController
  def index
    @posts = post.order('posts.name ASC').page(params[:page])
  end
end
```

Write the template for your list of lessons in `app/views/posts/index.html.erb`:

```erb
<div class="infinite-table">
  <table>
    <tr>
      <th>Post</th>
      <th></th>
    </tr>
    <%= render :partial => 'posts', :object => @lessons %>
  </table>
  <p class="pagination">
    <%= link_to_next_page(@posts, 'Next Page', :remote => true) %>
  </p>
</div>
```

...and `app/views/posts/_posts.html.erb`:

```erb
<% @posts.each do |post| %>
  <tr>
    <td><%= post.title %></td>
    <td><%= post.content %></td>
  </tr>
<% end %>
```

Append new data to the table in `app/views/posts/index.js.erb`:

```javascript
// Append new data
$("<%=j render(:partial => 'posts', :object => @posts) %>")
  .appendTo($(".infinite-table table"));

// Update pagination link
<% if @lessons.last_page? %>
  $('.pagination').html("That's all, folks!");
<% else %>
  $('.pagination')
    .html("<%=j link_to_next_page(@posts, 'Next Page', :remote => true) %>");
<% end %>
```

At this point, the pagination link at the bottom of your table should allow you
to load the next page without refreshing. Finally, we trigger the next page load
with the `infinitePages` plugin in `app/assets/javascripts/lessons.js.coffee`:

```coffee
$ ->
  # Configure infinite table
  $('.infinite-table').infinitePages
    # debug: true
    loading: ->
      $(this).text('Loading next page...')
    error: ->
      $(this).button('There was an error, please try again')
```

Voila! You should now have an infinitely long list of lessons.
