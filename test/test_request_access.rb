require 'wondeclient'
require 'minitest/autorun'
class WondeTest < Minitest::Test
  def test_returns_schools
    response = @@client.requestAccess("A0000000000")
    assert trueß
  end

end
