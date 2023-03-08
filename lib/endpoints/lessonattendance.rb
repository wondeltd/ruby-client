module Wonde
  class LessonAttendance < Endpoints
    @@uri = 'attendance/lesson/'
    def initialize(token, id=false)
      super(token, id)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = self.uri.gsub("//", "/").chomp("/")
    end
    def lesson_register(register)
      throw InvalidSessionException unless register.class == LessonRegister
      post({ attendance: register.attendance })
    end
  end
end
