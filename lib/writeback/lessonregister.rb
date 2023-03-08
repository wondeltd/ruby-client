module Wonde
  class LessonRegister
    attr_accessor :attendance
    def initialize
      @attendance = []
    end

    def to_json
      { 'attendance' => [attendance] }.to_json
    end

    def add(attendance_record)
      attendance.push(attendance_record.toArray)
      unless attendance_record.instance_of?(LessonAttendanceRecord)
        throw InvalidLessonAttendanceException, 'Attendance is not an instance of the LessonAttendance Class.'
      end

      throw InvalidLessonAttendanceException, 'Attendance has empty fields.' unless attendance_record.isValid
    end
  end
end
