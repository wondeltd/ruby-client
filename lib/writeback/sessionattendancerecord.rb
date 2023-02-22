module Wonde
  class SessionAttendanceRecord
    require 'time'
    attr_accessor :student_id, :date, :session, :attendance_code_id, :comment, :minutes_late, :employee_id

    #most of these methods are here to be compatible 1:1 with the php module, standard ruby getters and setters should still work too

    def setStudentId(studentId)
        if studentId.empty? or studentId.nil?
            throw InvalidAttendanceException, 'Student id can not be set to null.'
        end
        @student_id = studentId
    end

    def setAttendanceCodeId(attendanceCodeId)
      if attendanceCodeId.empty? or attendanceCodeId.nil?
          throw InvalidAttendanceException, 'Attendance code id can not be set to null.'
      end
      @attendance_code_id = attendanceCodeId
    end

    def setDate(date)
      if date.empty? or date.nil?
        throw InvalidAttendanceException, 'Date can not be set to null.'
      end
      begin
        mytime = Time.parse(date).to_i
      rescue
        throw InvalidAttendanceException, 'Date provided is invalid'
      end
      newdate = Time.at(mytime)
      self.date = newdate.to_date.to_s
    end


    def setSession(session)
        session = session.upcase

        if (session == 'AM' || session == 'PM')
            self.session = session
        else
            throw InvalidSessionException, 'The session is invalid'
        end
    end

    def isValid()
      return ! (self.getDate().empty? || self.getStudentId().empty? || self.getSession().empty? || self.getAttendanceCodeId().empty?)
    end

    def getStudentId()
        return self.student_id
    end

    def getAttendanceCodeId()
        return self.attendance_code_id
    end

    def getDate()
        return self.date.to_s
    end

    def getSession()
        return self.session
    end

    def toArray()
        required = {
          'date':               self.getDate(),
          'session':            self.getSession(),
          'student_id':         self.getStudentId(),
          'attendance_code_id': self.getAttendanceCodeId()
        }
        unless self.getComment.nil? or self.getComment.empty?
          required[:comment] = self.getComment()
        end

        unless self.getMinutesLate.nil? or self.getMinutesLate.empty?
          required[:minutes_late] = self.getMinutesLate()
        end

        unless self.getEmployeeId.nil? or self.getEmployeeId.empty?
          required[:employee_id] =  self.getEmployeeId()
        end

        return required
    end

    def getComment()
        return self.comment;
    end

    def setComment(comment)
        self.comment = comment;
    end

    def getMinutesLate()
        self.minutes_late;
    end

    def setMinutesLate(minutes_late)
        self.minutes_late = minutes_late;
    end

    def getEmployeeId()
        self.employee_id;
    end

    def setEmployeeId(employee_id)
      self.employee_id = employee_id;
    end
  end
end
