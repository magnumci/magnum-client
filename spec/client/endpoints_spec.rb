require "spec_helper"

describe Magnum::Client::Endpoints do
  let(:connection) { Magnum::Client::Connection.new("token") }

  describe "#get_profile" do
    before do
      stub_api(:get, "/profile",
        headers: {"X-API-KEY" => "token"},
        status: 200,
        body: fixture("profile.json")
      )
    end

    it "returns user profile" do
      profile = connection.get_profile

      expect(profile.id).to eq 1
      expect(profile.email).to eq "dan.sosedoff@gmail.com"
      expect(profile.login).to eq "sosedoff"
      expect(profile.projects).to eq 1
      expect(profile.created_at).not_to eq nil
    end
  end
end