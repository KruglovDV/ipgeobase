# frozen_string_literal: true

require "net/http"
require "bundler/setup"
require "nokogiri-happymapper"

require_relative "ipgeobase/version"

module Ipgeobase
  class Error < StandardError; end

  def self.lookup(ip)
    response = Net::HTTP.get "ip-api.com", "/xml/#{ip}"
    HappyMapper.parse response
  end
end
