module Wonde
  class LessonAttendanceRecord
    attr_accessor :student_id, :lesson_id, :attendance_code_id

    #most of these methods are here to be compatible 1:1 with the php module, standard ruby getters and setters should still work too

    def setStudentId(studentId)
        if studentId.empty? or studentId.nil?
            throw InvalidLessonAttendanceException, 'Student id can not be set to null.'
        end
        @student_id = studentId
    end

    def setLessonId(lessonId)
      if lessonId.empty? or lessonId.nil?
          throw InvalidLessonAttendanceException, 'Lesson id can not be set to null.'
      end
      @lesson_id = lessonId
    end

    def setAttendanceCodeId(attendanceCodeId)
      if attendanceCodeId.empty? or attendanceCodeId.nil?
          throw InvalidLessonAttendanceException, 'Attendance code id can not be set to null.'
      end
      @attendance_code_id = attendanceCodeId
    end

    def isValid()
      return ! (self.getStudentId().empty? || self.getLessonId().empty? || self.getAttendanceCodeId().empty?)
    end

    def getStudentId()
        return self.student_id
    end

    def getLessonId()
        return self.lesson_id
    end

    def getAttendanceCodeId()
        return self.attendance_code_id
    end

    def toArray()
        required = {
            'lesson_id':          self.getLessonId(),
            'student_id':         self.getStudentId(),
            'attendance_code_id': self.getAttendanceCodeId()
        }
        return required
    end
  end
end
