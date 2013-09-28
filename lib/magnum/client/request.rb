module Magnum::Client
  module Request
    API_BASE = "https://magnum-ci.com"

    def get(path, params={})
      request(:get, path, params)
    end

    private

    def request(method, path, params={})
      path    = "/api/v1/#{path}"
      headers = { "X-API-KEY" => @api_key }

      response = endpoint(API_BASE).send(method, path, params) do |request|
        request.headers = headers
        request.url(path, params)
      end

      json = JSON.parse(response.body)

      if response.success?
        json
      else
        raise Error, json["error"]
      end
    end

    def endpoint(url)
      connection = Faraday.new(url, {}) do |c|
        c.use(Faraday::Request::UrlEncoded)
        c.use(Faraday::Response::Logger) if @debug
        c.adapter(Faraday.default_adapter)
      end
    end
  end
end