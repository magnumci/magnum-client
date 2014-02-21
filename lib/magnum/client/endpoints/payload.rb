class Magnum::Client
  module Endpoints
    module Payload
      # Send a new build payload
      #
      # token - Project API token
      # payload - Commit JSON payload
      #
      def send_payload(token, payload)
        post("payload", token: token, payload: payload)
      end
    end
  end
end