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
end