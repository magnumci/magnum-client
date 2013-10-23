require "spec_helper"

describe Magnum::Client::Endpoints do
  let(:client) { Magnum::Client.new("token") }

  describe "#authenticate" do
    context "blank credentials" do
      before do
        stub_api(:post, "/authenticate?email=&password=",
          status: 400,
          body: fixture("auth_credentials_required.json")
        )
      end

      it "returns error" do
        expect { client.authenticate("", "") }.
          to raise_error Magnum::Client::Error, "User login or email is required"
      end
    end

    context "invalid credentials" do
      before do
        stub_api(:post, "/authenticate?email=foo&password=bar",
          status: 400,
          body: fixture("auth_invalid_credentials.json")
        )
      end

      it "returns error" do
        expect { client.authenticate("foo", "bar") }.
          to raise_error Magnum::Client::Error, "Invalid credentials"
      end
    end
  end

  describe "#profile" do
    before do
      stub_api(:get, "/profile",
        headers: {"X-API-KEY" => "token"},
        status: 200,
        body: fixture("profile.json")
      )
    end

    it "returns user profile" do
      profile = client.profile

      expect(profile.id).to eq 1
      expect(profile.email).to eq "dan.sosedoff@gmail.com"
      expect(profile.login).to eq "sosedoff"
      expect(profile.projects).to eq 1
      expect(profile.created_at).not_to eq nil
    end
  end

  describe "#projects" do
    before do
      stub_api(:get, "/projects",
        headers: {"X-API-KEY" => "token"},
        status: 200,
        body: fixture("projects.json")
      )
    end

    it "returns collection of projects" do
      projects = client.projects

      expect(projects).to be_an Array
      expect(projects.size).to eq 1
    end
  end

  describe "#project" do
    before do
      stub_api(:get, "/projects/1",
        headers: {"X-API-KEY" => "token"},
        status: 404,
        body: fixture("project_not_found.json")
      )

      stub_api(:get, "/projects/15",
        headers: {"X-API-KEY" => "token"},
        status: 200,
        body: fixture("project.json")
      )
    end

    it "returns project details" do
      project = client.project(15)

      expect(project.id).to eq 15
      expect(project.provider).to eq "github"
      expect(project.project_type).to eq "ruby"
      expect(project.source_type).to eq "git"
      expect(project.source_url).to match /github.com:sosedoff\/foobar.git/
      expect(project.builds_count).to eq 130
      expect(project.failed_builds_count).to eq 6
      expect(project.enabled).to eq true
      expect(project.build_status).to eq "pass"
      expect(project.created_at).not_to be_empty
      expect(project.updated_at).not_to be_empty
      expect(project.last_build_at).not_to be_empty
    end
  end

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