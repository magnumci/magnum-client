module Magnum::Client
  module Endpoints
    def authenticate(email, password)
      request(:post, "authenticate", {
        email: email,
        password: password
      })
    end

    def profile
      request(:get, "profile")
    end

    def projects
      request(:get, "projects")
    end

    def project(id)
      request(:get, "projects/#{id}")
    end

    def create_project(options={})
      request(:post, "projects", project: options)
    end

    def update_project(project_id, options={})
      request(:put, "projects/#{project_id}", project: options)
    end

    def delete_project(project_id)
      request(:delete, "projects/#{project_id}")
    end

    def project_builds(project_id)
      request(:get, "projects/#{project_id}/builds")
    end

    def project_build(project_id, build_id)
      request(:get, "projects/#{project_id}/builds/#{build_id}")
    end

    def delete_build(project_id, build_id)
      request(:delete, "projects/#{project_id}/builds/#{build_id}")
    end
  end
end