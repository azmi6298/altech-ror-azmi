require 'faraday'
require 'json'

module FetchCountryHelper
  def fetch_country(country_code: nil)
    if !country_code.present?
      query = {
        'query' => "{ countries { code name native capital emoji currency }\n}\n"
      }.to_json
      response = fetch_from_api(query)
      JSON.parse(response.body, symbolize_names: true)[:data][:countries].map do |country|
        decorate_country(country)
      end
    else
      query = {
        'query' => "{ country(code: \"#{country_code}\") { code name native capital emoji currency }\n}"
      }.to_json
      response = fetch_from_api(query)
      country = JSON.parse(response.body, symbolize_names: true)[:data][:country]
      decorate_country(country)
    end
  end

  private

  def fetch_from_api(query)
    url = 'https://countries.trevorblades.com/'
    Faraday.post(url, query, {'Content-Type' =>'application/json', 'Accept' => 'application/json'})
  end

  def decorate_country(country)
    Country.new(
      name: country[:name],
      code: country[:code],
      native: country[:native],
      emoji: country[:emoji],
      capital: country[:capital],
      currency: country[:currency]
    )
  end
end