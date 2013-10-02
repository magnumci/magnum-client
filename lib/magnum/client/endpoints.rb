class Magnum::Client
  module Endpoints
    def authenticate(email, password)
      request(:post, "authenticate", {
        email: email,
        password: password
      })
    end

    def profile
      get("profile")
    end

    def update_profile(attributes={})
      put("profile", user: attributes)
    end

    def projects
      get("projects")
    end

    def project(id)
      get("projects/#{id}")
    end

    def project_config(id)
      get("projects/#{id}/config")
    end

    def create_project(options={})
      post("projects", project: options)
    end

    def update_project(project_id, options={})
      put("projects/#{project_id}", project: options)
    end

    def delete_project(project_id)
      delete("projects/#{project_id}")
    end

    def project_builds(project_id)
      get("projects/#{project_id}/builds")
    end

    def project_build(project_id, build_id)
      get("projects/#{project_id}/builds/#{build_id}")
    end

    def delete_build(project_id, build_id)
      delete("projects/#{project_id}/builds/#{build_id}")
    end
  end
end