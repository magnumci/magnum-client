require "spec_helper"

describe Magnum::Client::Endpoints do
  let(:client) { Magnum::Client.new("token") }

  describe "#build" do
    context "project does not exist" do
      before do
        stub_api(:get, "/projects/1/builds/1",
          headers: {"X-API-KEY" => "token"},
          status: 404,
          body: fixture("project_not_found.json")
        )
      end

      it "raises error" do
        expect { client.build(1, 1) }.
          to raise_error Magnum::Client::Error, "Project does not exist"
      end
    end

    context "build does not exist" do
      before do
        stub_api(:get, "/projects/1/builds/1",
          headers: {"X-API-KEY" => "token"},
          status: 404,
          body: fixture("build_not_found.json")
        )
      end

      it "raises error" do
        expect { client.build(1, 1) }.
          to raise_error Magnum::Client::Error, "Build does not exist"
      end
    end

    context "build exists" do
      before do
        stub_api(:get, "/projects/1/builds/1",
          headers: {"X-API-KEY" => "token"},
          status: 200,
          body: fixture("build.json")
        )
      end

      it "returns build details" do
        build = client.build(1, 1)

        expect(build).to include(
          :id,
          :project_id,
          :title,
          :number,
          :commit,
          :author,
          :committer,
          :message,
          :branch,
          :state,
          :status,
          :result,
          :duration,
          :duration_string,
          :commit_url,
          :compare_url,
          :created_at,
          :started_at,
          :finished_at
        )
      end
    end
  end

  describe "#reset_build" do
    context "build is running" do
      before do
        stub_api(:post, "/projects/1/builds/1/reset",
          headers: {"X-API-KEY" => "token"},
          status: 400,
          body: fixture("build_reset_error.json")
        )
      end

      it "raises error" do
        expect { client.reset_build(1,1) }.
          to raise_error "Build is not finished"
      end
    end

    context "build is finished" do
      before do
        stub_api(:post, "/projects/1/builds/1/reset",
          headers: {"X-API-KEY" => "token"},
          status: 200,
          body: fixture("build_reset.json")
        )
      end

      it "resets build" do
        expect(client.reset_build(1,1)["reset"]).to eq true
      end
    end
  end
end