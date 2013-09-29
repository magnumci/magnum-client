# magnum-client

Ruby wrapper for [Magnum CI](https://magnum-ci.com) API

![Build Status](https://magnum-ci.com/status/6bd1331c22d63cad996a90bc02710106.png)

## Usage

Examples:

```ruby
require "magnum/client"

# Setup API client
client = Magnum::Client.new("api_token")

# Or authenticate
client = Magnum::Client.new
client.authenticate("email", "password")

# Get user profile
client.profile

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

## Testing

To run test suite execute:

```
bundle exec rake test
```