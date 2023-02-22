module Wonde
  class SessionRegister
    attr_accessor :attendance

    def initialize
      # require array of attendance atrributes by de api
      @attendance = []
    end

    def to_json
      { 'attendance' => [attendance] }.to_json
    end

    def add(attendance_record)
      attendance.push(attendance_record.toArray)
      unless attendance_record.instance_of?(SessionAttendanceRecord)
        throw InvalidAttendanceException, 'Attendance is not an instance of the Attendance Class.'
      end

      throw InvalidAttendanceException, 'Attendance has empty fields.' unless attendance_record.isValid
    end
  end
end
