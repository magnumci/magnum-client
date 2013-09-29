module Magnum::Client
  module Endpoints
    def authenticate(email, password)
      request(:post, "authenticate", {
        email: email,
        password: password
      })
    end

    def get_profile
      request(:get, "profile")
    end

    def get_projects
      request(:get, "projects")
    end

    def get_project(id)
      request(:get, "projects/#{id}")
    end

    def get_project_builds(project_id)
      request(:get, "projects/#{project_id}/builds")
    end

    def get_project_build(project_id, build_id)
      request(:get, "projects/#{project_id}/builds/#{build_id}")
    end
  end
end