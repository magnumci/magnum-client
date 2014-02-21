class Magnum::Client
  module Endpoints::Authentication
    def authenticate(email, password)
      post("authenticate", email: email, password: password)
    end
  end
end