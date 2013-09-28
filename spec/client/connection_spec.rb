require "spec_helper"

describe Magnum::Client::Connection do
  let(:connection) { Magnum::Client::Connection.new("token") }

  describe "invalid endpoint" do
    before do
      stub_api(:get, "/foobar?api_key=token", status: 404, body: fixture("invalid_endpoint.json"))
    end

    it "raises error" do
      expect { connection.get("foobar") }.
        to raise_error Magnum::Client::Error, "Invalid endpoint"
    end
  end

  describe "invalid api key" do
    before do
      stub_api(:get, "/profile?api_key=token", status: 401, body: fixture("invalid_key.json"))
    end

    it "raises error" do
      expect { connection.get("profile") }.
        to raise_error Magnum::Client::Error, "API key is invalid"
    end
  end
end