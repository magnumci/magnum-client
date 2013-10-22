class Magnum::Client
  module Endpoints
    module Builds
      
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
end