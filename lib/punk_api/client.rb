require 'json'
require 'net/http'

require_relative '../lex_response'

module PunkApi
  class Client
    API_URL = 'https://api.punkapi.com/v2'.freeze

    def beers(params = {})
      url = url_for('/beers', params)
      parse(Net::HTTP.get(url))
    end

    def random
      url = url_for('/beers/random', {})
      parse(Net::HTTP.get(url))
    end

    private

    def url_for(path, params)
      request_url = [API_URL, path].join

      uri = URI(request_url)
      uri.query = URI.encode_www_form(params)
      uri
    end

    def parse(response)
      data = JSON.parse(response)
      if data.is_a?(Hash) && data['statusCode']
        { success: false, data: data['message'] }
      else
        { success: true, data: data.sample }
      end
    end
  end
end
