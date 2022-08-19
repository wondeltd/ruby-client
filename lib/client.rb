require 'pp'
# Main Module/Namespace to hold all the Wonde classes
#
module Wonde
  # Main client class that the user will interface with
  #
  # @param token [String]
  # @return [Object]
  #
  # @example
  #   require 'wondeclient'
  #   client = Wonde::Client.new('TOKEN_GOES_HERE')
  #   client.schools.all().each do |school|
  #     p school.name
  #   end
  class Client
    attr_accessor :schools, :attendanceCodes, :token
    @@attendanceCodes
    @@token
    @@version = '0.0.6'

    # Initialize a Client Object
    #
    # @param token [String]
    # @return [Object]
    #
    # @example
    #   Wonde::Client.new("SOMETOKEN") #=> #<Wonde::Client:0x007fb223953da0 @token="SOMETOKEN">
    def initialize(token)
      @@token = token
      @token = token
      @schools = Wonde::Schools.new(token)
      @attendanceCodes = Wonde::AttendanceCodes.new(token)
    end

    # Get School/Schools Object
    #
    # @param id [String]
    # @return [Object]
    #
    # @example
    #   client = Wonde::Client.new("SOMETOKEN")
    #   school = client.school('SCHOOLID')
    def school(id)
      return Wonde::Schools.new(@token, id)
    end

    # requestAccess endpoint POST
    #
    # @param schoolId [String]
    # @return [Object]
    #
    # @example
    #   client = Wonde::Client.new("SOMETOKEN")
    #   client.requestAccess("A0000000000")
    def requestAccess(schoolId)
      return Wonde::Endpoints.new(@token, ('schools/' + schoolId + '/request-access')).post()
    end

    # revokeAccess endpoint DELETE
    #
    # @param schoolId [String]
    # @return [Object]
    #
    # @example
    #   client = Wonde::Client.new("SOMETOKEN")
    #   client.revokeAccess('A0000000000')
    def revokeAccess(schoolId)
      return Wonde::Endpoints.new(@token, ('schools/' + schoolId + '/revoke-access')).delete()
    end

  end
end
