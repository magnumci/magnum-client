module Magnum::Client
  module Request
    API_BASE = "https://magnum-ci.com"

    def get(path, params={})
      request(:get, path, params)
    end

    private

    def request(method, path, params={})
      path    = "/api/v1/#{path}"
      headers = {"Accept" => "application/json"}

      if @api_key
        headers["X-API-KEY"] = @api_key
      end

      response = endpoint(API_BASE).send(method, path, params) do |request|
        request.headers = headers
        request.url(path, params)
      end

      json = JSON.parse(response.body)

      if response.success?
        format_response(json)
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

    def format_response(data)
      case data
      when Array
        data.map { |obj| Hashie::Mash.new(obj) }
      else
        Hashie::Mash.new(data)
      end
    end
  end
end