require "minitest/autorun"
require 'pry'

class Minitest::Test
  @@ACCESSTOKEN = ENV['CORE_TOKEN']
  @@SCHOOLID = ENV['WONDE_SCHOOL_ID']
  @@client = Wonde::Client.new(@@ACCESSTOKEN)
  ATTENDANCETOKEN = ENV['ATTENDANCE_PRO_TOKEN']
  BEHAVIOURTOKEN = ENV['BEHAVIOUR_TOKEN']
end
