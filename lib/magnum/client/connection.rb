module Magnum
  module Client
    class Connection
      attr_reader :api_key

      include Magnum::Client::Request
      include Magnum::Client::Endpoints

      def initialize(api_key=nil)
        @api_key = api_key
        @debug = false
      end
    end
  end
end