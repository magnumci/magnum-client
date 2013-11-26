class Magnum::Client
  module Request
    API_BASE = "https://magnum-ci.com"

    def get(path, params = {})    ; request(:get, path, params)    ; end
    def post(path, params = {})   ; request(:post, path, params)   ; end
    def put(path, params = {})    ; request(:put, path, params)    ; end
    def delete(path, params = {}) ; request(:delete, path, params) ; end

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

      handle_response(response)
    end

    def endpoint(url)
      connection = Faraday.new(url, {}) do |c|
        c.use(Faraday::Request::UrlEncoded)
        c.use(Faraday::Response::Logger) if @debug
        c.adapter(Faraday.default_adapter)
      end
    end

    def handle_response(response)
      json = JSON.parse(response.body)

      if response.success?
        format_response(json)
      else
        handle_response_error(response, json)
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

    def handle_response_error(response, json)
      case response.status
      when 401
        raise AuthError, json["error"]
      else
        raise Error, json["error"]
      end
    end
  end
end