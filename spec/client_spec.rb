require "spec_helper"

describe Magnum::Client do
  describe ".new" do
    it "returns Magnum::Client::Connection instance" do
      client = Magnum::Client.new("foobar")

      expect(client).to be_a Magnum::Client::Connection
      expect(client.api_key).to eq "foobar"
    end
  end
end