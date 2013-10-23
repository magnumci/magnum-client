class Magnum::Client
  module Endpoints
    module Builds

      def builds(project_id)
        get("projects/#{project_id}/builds")
      end

      def build(project_id, id)
        get("projects/#{project_id}/builds/#{id}")
      end

      def build_log(project_id, id)
        get("projects/#{project_id}/builds/#{id}/log")
      end

      def reset_build(project_id, id)
        post("projects/#{project_id}/builds/#{id}/reset")
      end

      def delete_build(project_id, id)
        delete("projects/#{project_id}/builds/#{id}")
      end

    end
  end
end