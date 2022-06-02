# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "ipgeobase"

require "minitest/autorun"
require "webmock/minitest"

def load_fixture(filename)
  File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
end
