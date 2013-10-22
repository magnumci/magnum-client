require "spec_helper"

describe Magnum::Client do
  let(:client) { Magnum::Client.new("token") }

  describe "invalid endpoint" do
    before do
      stub_api(:get, "/foobar",
        headers: {"X-API-KEY" => "token"},
        status: 404,
        body: fixture("invalid_endpoint.json")
      )
    end

    it "raises error" do
      expect { client.get("foobar") }.
        to raise_error Magnum::Client::Error, "Invalid endpoint"
    end
  end

  describe "missing api key" do
    before do
      stub_api(:get, "/profile",
        headers: {"X-API-KEY" => ""},
        status: 401, 
        body: fixture("key_required.json")
      )
    end

    it "raises error" do
      expect { client.get("profile") }.
        to raise_error Magnum::Client::AuthError, "API key required"
    end
  end

  describe "invalid api key" do
    before do
      stub_api(:get, "/profile",
        headers: {"X-API-KEY" => "token"},
        status: 401, 
        body: fixture("invalid_key.json")
      )
    end

    it "raises error" do
      expect { client.get("profile") }.
        to raise_error Magnum::Client::AuthError, "API key is invalid"
    end
  end
end