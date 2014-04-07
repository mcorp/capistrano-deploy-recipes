> NOTICE: we are on the early stages. ;)

# Capistrano Deploy Recipes

Just a bunch of useful Capistrano V3 deploy recipes.

## The need

We wanted a better way to deploy our apps into a _blank_ VPS or server
and we would be so happy if all the dependencies (ruby, unicorn, nginx,
postgres and so on) get installed by Capistrano.

To make the stack deploy easier we can use a base image for the machines
(which, by the way, we do have) or use tools like [Puppet][0] and [Cheff][1]
or services like [configr][2]. Those options are great and will fit for
many situations, but (there is always a but)...

But sometimes wouldn't it be lovely if a simple `cap production deploy`
solve it all?

Watching [RailsCast episode 337][3], Ryan Bates showed a simple way
to achieve that.

Googling around we found some gems that seems to do that, but they dont
have recipes to install the dependencies as we want.

## Installation

```ruby
group :development do
  gem 'capistrano'
  gem 'capistrano-deploy-recipes', github: 'mcorp/capistrano-deploy-recipes'
end
```

## Usage

Add on your `Capfile` file the recipes you want to use

```ruby
require 'recipes/ruby'
require 'recipes/nodejs'
require 'recipes/nginx'
require 'recipes/postgres'
```

> Those requires must go inside `Capfile` and not on `deploy.rb`


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2014 [mcorp.io][4]

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NON INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[0]: http://puppetlabs.com
[1]: http://www.getchef.com/chef/
[2]: https://configr.com
[3]: http://railscasts.com/episodes/337-capistrano-recipes
[4]: http://mcorp.io
