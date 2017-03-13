module Wonde
  class SessionRegister
    attr_accessor :attendance
    def initialize()
      self.attendance = Array.new()
    end

    def to_json()
            {'attendance' => [self.attendance]}.to_json
    end

    def add(attendance)
      newattendance = Array.new()
      newattendance.push(attendance)
      newattendance.each do |attendanceSingular|
        if attendanceSingular.class == SessionAttendanceRecord && attendanceSingular.isValid()
          self.attendance = attendanceSingular.toArray()
        else
          unless attendanceSingular.class == SessionAttendanceRecord
            throw InvalidAttendanceException, 'Attendance is not an instance of the Attendance Class.'
          end
          unless attendanceSingular.isValid()
            throw InvalidAttendanceException, 'Attendance has empty fields.'
          end
            throw InvalidAttendanceException
        end
      end
    end
  end
end
