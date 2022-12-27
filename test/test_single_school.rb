require 'wondeclient'
require 'minitest/autorun'
class WondeTest < Minitest::Test
  def test_single_school
    school = @@client.schools.get(@@SCHOOLID)
    assert !school.nil? && school['name'].class == String
  end
end
