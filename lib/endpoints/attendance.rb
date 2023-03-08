module Wonde
  class Attendance < Endpoints
    @@uri = 'attendance/session'
    def initialize(token, id=false)
      super(token, id)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = self.uri.gsub("//", "/").chomp("/")
    end

    def session_register(register)
      throw InvalidSessionException unless register.class == SessionRegister
      post({ attendance: register.attendance })
    end
  end
end
