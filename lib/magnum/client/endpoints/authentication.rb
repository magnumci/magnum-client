class Magnum::Client
  module Endpoints
    module Authentication

      def authenticate(email, password)
        request(:post, "authenticate", {
          email: email,
          password: password
        })
      end
      
    end
  end
end