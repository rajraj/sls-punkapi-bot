require 'json'

require_relative './lib/punk_api/client'
require_relative './lib/lex_response'

def handler(event:, context:)
  food = event.dig('currentIntent', 'slots', 'Food')
  result = fetch_beer(food)

  response = LexResponse.new(result)
  response.generate
end

def fetch_beer(food = nil)
  if food.nil?
    PunkApi::Client.new.random
  else
    PunkApi::Client.new.beers(food: food)
  end
end
