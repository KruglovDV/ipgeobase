# frozen_string_literal: true

require_relative "../test_helper"

class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_it_returns_info
    response = load_fixture("response.xml")
    ip = "8.8.8.8"
    stub_request(:get, "#{Ipgeobase::API}/#{ip}")
      .to_return(status: 200, body: response, headers: {})
    expected = { city: "Ashburn", country: "United States", country_code: "US", lat: "39.03", lon: "-77.5" }
    result = Ipgeobase.lookup(ip)
    assert result.city, expected["city"]
    assert result.country, expected["country"]
    assert result.country_code, expected["country_code"]
    assert result.lat, expected["lat"]
    assert result.lon, expected["lon"]
  end
end
