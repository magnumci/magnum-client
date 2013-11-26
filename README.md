# magnum-client

Ruby API wrapper for [Magnum CI](https://magnum-ci.com)

[![build status](https://magnum-ci.com/status/6bd1331c22d63cad996a90bc02710106.png)](https://magnum-ci.com/public/56ee5f54ab276bcc6396/builds)

## Install

Add this line to your application's Gemfile:

```
gem "magnum-client"
```

And then execute:

```
bundle
```

Or install it yourself as:

```
$ gem install magnum-client
```

## Usage

Require client:

```ruby
require "magnum/client"
```

### Authentication

Connection with existing API token:

```ruby
client = Magnum::Client.new("api_token")
```

Authenticate user:

```ruby
client = Magnum::Client.new
client.authenticate("email", "password")
```

### User Profile

Get user profile:

```ruby
client.profile
```

Update user profile:

```ruby
client.update_profile(login: "jimi", email: "jimi@hendrix.com")
```

### Projects

```ruby
# Get projects
client.projects

# Get a single project
client.project(12345)

# Create a new project
client.create_project(
  name: "foobar",
  source_url: "git@github.com:foo/bar.git"
)

# Update existing project
client.update_project(
  name: "newname"
  source_url: "git@gitlab.com:foo/bar.git"
  provider: "gitlab"
)

# Delete existing project
client.delete_project(12345)
```

### Builds

```ruby
project_id = 12345

# Get project builds
client.builds(project_id)

# Get a single build
client.build(project_id, 12345)

# Get build log
client.build_log(project_id, 12345)

# Delete a build
client.delete_build(project_id, 12345)
```

### Commit Payloads

Send commit payload:

```ruby
Magnum::Client.send_payload("project token", "provider", "data")
```

## Testing

To run test suite execute:

```
bundle exec rake test
```

## License

Copyright (c) 2013 Dan Sosedoff, Magnum CI

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
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.