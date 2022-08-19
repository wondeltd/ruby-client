module Wonde
  class Attendance < Endpoints
    @@uri = 'attendance/session'
    def initialize(token, id=false, endpoint = nil)
      super(token, id, endpoint)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = self.uri.gsub("//", "/").chomp("/")
    end

    def sessionRegister(register)
      throw InvalidSessionException unless register.class == SessionRegister
      return self.post(register)
    end
  end
end
