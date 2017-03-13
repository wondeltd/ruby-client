require "minitest/autorun"

class Minitest::Test
  @@ACCESSTOKEN = ENV["wonde-token"]
  @@SCHOOLID = ENV["wonde-school-id"]
  @@client = Wonde::Client.new(@@ACCESSTOKEN)
end
