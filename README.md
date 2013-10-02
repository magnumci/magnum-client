# magnum-client

Ruby wrapper for [Magnum CI](https://magnum-ci.com) API

![Build Status](https://magnum-ci.com/status/6bd1331c22d63cad996a90bc02710106.png)

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

```
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

## Testing

To run test suite execute:

```
bundle exec rake test
```