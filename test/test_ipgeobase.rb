# frozen_string_literal: true

require "test_helper"

RESPONSE = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<query>
  <status>success</status>
  <country>United States</country>
  <countryCode>US</countryCode>
  <region>VA</region>
  <regionName>Virginia</regionName>
  <city>Ashburn</city>
  <zip>20149</zip>
  <lat>39.03</lat>
  <lon>-77.5</lon>
  <timezone>America/New_York</timezone>
  <isp>Google LLC</isp>
  <org>Google Public DNS</org>
  <as>AS15169 Google LLC</as>
  <query>8.8.8.8</query>
</query>"

class TestIpgeobase < Minitest::Test
  def setup
    stub_request(:get, "http://ip-api.com/xml/8.8.8.8")
      .to_return(body: RESPONSE, status: 200)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_it_returns_info
    expected = {
      city: "Ashburn",
      country: "United States",
      country_code: "US",
      lat: "39.03",
      lon: "-77.5"
    }
    result = Ipgeobase.lookup("8.8.8.8")
    assert result.city, expected["city"]
    assert result.country, expected["country"]
    assert result.country_code, expected["@country_code"]
    assert result.lat, expected["lat"]
    assert result.lon, expected["lon"]
  end
end
