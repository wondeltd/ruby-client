require 'wondeclient'
require 'minitest/autorun'
class WondeTest < Minitest::Test

  def test_lesson_attendance
    client = Wonde::Client.new(ATTENDANCETOKEN)
    response = client.school(@@SCHOOLID).lessonAttendance.all()
    assert response.key?('data')
  end


  def test_behaviours_attributes
    client = Wonde::Client.new(BEHAVIOURTOKEN)
    response = client.school(@@SCHOOLID).behavioursAttributes.all()
    assert response.key?('data')
  end


  def test_achievements_attributes
    client = Wonde::Client.new(BEHAVIOURTOKEN)
    response = client.school(@@SCHOOLID).achievementsAttributes.all()
    assert response.key?('data')
  end
end

