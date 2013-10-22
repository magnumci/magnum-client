require "magnum/client/endpoints/authentication"
require "magnum/client/endpoints/profile"
require "magnum/client/endpoints/projects"
require "magnum/client/endpoints/builds"

class Magnum::Client
  module Endpoints
    include Authentication
    include Profile
    include Projects
    include Builds
  end
end