class Magnum::Client
  module Endpoints
    module Projects

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
      
    end
  end
end