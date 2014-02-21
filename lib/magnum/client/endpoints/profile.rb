class Magnum::Client
  module Endpoints::Profile
    def profile
      get("profile")
    end

    def update_profile(attributes={})
      put("profile", user: attributes)
    end
  end
end