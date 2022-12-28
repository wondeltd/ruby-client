require 'wondeclient'
require 'minitest/autorun'
class WondeTest < Minitest::Test
  def test_request_access
    response = @@client.requestAccess(@@SCHOOLID)
    assert response
  end
end
