# magnum-client

Ruby wrapper for [Magnum CI](https://magnum-ci.com) API

## Usage

Examples:

```ruby
require "magnum/client"

# Setup API client
client = Magnum::Client.new("api_token")

# Get user profile
client.get_profile

# Get projects
client.get_projects

# Get a single project
client.get_project(12345)
```

## Testing

To run test suite execute:

```
bundle exec rake test
```