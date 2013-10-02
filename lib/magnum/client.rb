require "faraday"
require "json"
require "hashie"

require "magnum/client/version"
require "magnum/client/request"
require "magnum/client/endpoints"

module Magnum
  class Client
    attr_accessor :api_key, :debug

    include Magnum::Client::Request
    include Magnum::Client::Endpoints

    class Error     < StandardError ; end
    class AuthError < Error ; end

    def initialize(api_key=nil)
      @api_key = api_key
      @debug = false
    end
  end
end
