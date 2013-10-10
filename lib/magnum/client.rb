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
    # @param [String] provider name (github, bitbucket, gitlab, etc)
    # @param [Hash] payload data
    #
    def self.send_payload(project_token, provider, data)
      response = Faraday.post("https://magnum-ci.com/api/v1/payload/#{provider}",
        token: project_token,
        payload: data
      )

      response.success?
    end
  end
end
