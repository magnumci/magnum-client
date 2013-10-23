require "spec_helper"

describe Magnum::Client::Endpoints do
  let(:client) { Magnum::Client.new("token") }
  
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
end