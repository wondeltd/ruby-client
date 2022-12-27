require "minitest/autorun"
require 'pry'

class Minitest::Test
  @@ACCESSTOKEN = ENV['CORE_TOKEN']
  @@SCHOOLID = ENV['WONDE_SCHOOL_ID']
  @@client = Wonde::Client.new(@@ACCESSTOKEN)
end
