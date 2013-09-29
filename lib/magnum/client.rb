require "faraday"
require "json"
require "hashie"

require "magnum/client/version"

module Magnum
  module Client
    class Error < StandardError ; end
    class AuthError < Error ; end

    autoload :Connection, "magnum/client/connection"
    autoload :Request,    "magnum/client/request"
    autoload :Endpoints,  "magnum/client/endpoints"

    def self.new(api_key=nil)
      Magnum::Client::Connection.new(api_key)
    end
  end
end
