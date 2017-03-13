require 'wondeclient'
require 'minitest/autorun'
class WondeTest < Minitest::Test
  def test_returns_object
    client = Wonde::Client.new(@@ACCESSTOKEN)
    assert_equal client.class, Wonde::Client
  end
end
