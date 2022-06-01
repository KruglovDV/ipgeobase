# frozen_string_literal: true

require "uri"
require "net/http"
require "bundler/setup"
require "nokogiri-happymapper"
require "addressable/template"

require_relative "ipgeobase/version"
require_relative "ipgeobase/ip_info"

API = "http://ip-api.com/xml"

TEMPLATE = Addressable::Template.new("#{API}{/ip}")

module Ipgeobase
  def self.lookup(ip)
    uri = TEMPLATE.expand({ "ip" => ip }).to_s
    response = Net::HTTP.get(URI(uri))
    IPInfo.parse response, single: true
  end
end
