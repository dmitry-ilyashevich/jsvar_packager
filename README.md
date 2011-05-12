Jsvars packager
===============

Example
=======

In layout paste:

```ruby
return_jsvars('var Application.config')
```

Then anywhere in views:

```ruby
add_jsvars({:url => {:port => 80}})

...

add_jsvars({:url => {:hostname => 'localhost'}})
```

And you will get:

```html
<script>
var Application.config = {url: {hostname: 'localhost', :port => 80}};
</script>
```

Copyright (c) 2011 Dmitry A. Ilyashevich, released under the MIT license
