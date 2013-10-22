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

    # Send commit payload data to magnum
    #
    # @param [String] project API token
    # @param [Hash] payload data
    #
    def self.send_payload(project_token, data)
      response = Faraday.post("https://magnum-ci.com/receive",
        token: project_token,
        payload: data
      )

      result = JSON.load(response.body)

      if response.success?
        true
      else
        raise Error, result["error"]
      end
    end
  end
end
