require 'net/http'
require 'net/https'
require 'json'
require 'typhoeus'
class API
  def self.call_api(api_path, method, params={})
    api_base_url = 'https://api.instagram.com/v1/media/'
    req = Typhoeus::Request.new(api_base_url + api_path,
      :method => method,
      :timeout => 15000,
      :params => params
    )
    req.on_complete do |response|
      if response.success?
        begin
          data = JSON.parse(response.body)
        rescue
          data = {
            error: 101,
            body: [],
            message: "JSON Parser Error: #{response.body}"
          }
        end
      elsif response.timed_out?
        data = {
          error: 102,
          body: [],
          message: "Connection Timeout"
        }
      elsif response.code == 0
        # Could not get an http response, something's wrong.
        data = {
          error: 103,
          body: [],
          message: response.inspect
        }
      else
        # Received a non-successful http response.
        data = {
          error: 104,
          body: [],
          message: "HTTP request failed: #{response.code.to_s}"
        }
      end
      data
    end
    return req
  end
end