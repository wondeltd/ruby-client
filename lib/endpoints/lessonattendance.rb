module Wonde
  class LessonAttendance < Endpoints
    @@uri = 'attendance/lesson/'
    def initialize(token, id=false, endpoint = nil)
      super(token, id, endpoint)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = self.uri.gsub("//", "/").chomp("/")
    end
    def lessonRegister(register)
      throw InvalidSessionException unless register.class == LessonRegister
      return self.post(register)
    end
  end
end
