require 'wondeclient'
require 'minitest/autorun'

class WondeTest < Minitest::Test
  def test_returns_pending_schools
    array_of_schools = @@client.schools.all()['data']
    assert array_of_schools.class == Array && array_of_schools.length > 0
  end
end
