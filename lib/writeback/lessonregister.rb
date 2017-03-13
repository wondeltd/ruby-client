module Wonde
  class LessonRegister
    attr_accessor :attendance
    def initialize()
      self.attendance = Array.new()
    end

    def to_json()
            {'attendance' => [self.attendance]}.to_json
    end

    def add(lessonAttendance)
      newlessonattendance = Array.new()
      newlessonattendance.push(lessonAttendance)
      newlessonattendance.each do |lessonAttendanceSingular|
        if lessonAttendanceSingular.class == LessonAttendanceRecord && lessonAttendanceSingular.isValid()
          self.attendance = lessonAttendanceSingular.toArray()
        else
          unless lessonAttendanceSingular.class == LessonAttendanceRecord
            throw InvalidLessonAttendanceException, 'Attendance is not an instance of the LessonAttendance Class.'
          end
          unless lessonAttendanceSingular.isValid()
            throw InvalidLessonAttendanceException, 'Attendance has empty fields.'
          end
            throw InvalidLessonAttendanceException
        end
      end
    end
  end
end
