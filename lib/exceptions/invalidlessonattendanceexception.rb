module Wonde
  class InvalidLessonAttendanceException < StandardError
    def initialize(msg="Unknown InvalidLessonAttendanceException Error")
        super
    end
  end
end
