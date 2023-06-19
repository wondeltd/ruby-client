module Wonde
  class Schools < Endpoints
    attr_accessor :uri, :achievements, :attendance, :behaviours, :classes,
                  :contacts, :counts, :employees, :groups, :lessons,
                  :lessonAttendance, :medicalConditions, :medicalEvents,
                  :medicalNotes, :periods, :photos, :rooms, :subjects, :students,
                  :studentsPreAdmission,:achievementsAttributes,:behavioursAttributes,
                  :assessment, :deletions, :events, :attendanceSummaries, :detentions, :detentionTypes,
                  :attendanceDetention
    @@uri = 'schools/'
    def initialize(token, id=false)
      super(token, id)
      self.token = token
      self.uri = @@uri
      self.uri = @@uri + id + '/' if id
      self.uri = self.uri.gsub("//", "/").chomp("/")
      self.achievements        = Wonde::Achievements.new(token, self.uri)
      self.achievementsAttributes        = Wonde::AchievementsAttributes.new(token, self.uri)
      self.assessment          = Wonde::Assessment.new(token, self.uri)
      self.attendance          = Wonde::Attendance.new(token, self.uri)
      self.attendanceDetention = Wonde::AttendanceDetention.new(token, self.uri)
      self.behaviours          = Wonde::Behaviours.new(token, self.uri)
      self.behavioursAttributes          = Wonde::BehavioursAttributes.new(token, self.uri)
      self.classes             = Wonde::Classes.new(token, self.uri)
      self.contacts            = Wonde::Contacts.new(token, self.uri)
      self.counts              = Wonde::Counts.new(token, self.uri)
      self.deletions           = Wonde::Deletions.new(token, self.uri)
      self.detentions          = Wonde::Detentions.new(token, self.uri)
      self.detentionTypes      = Wonde::DetentionTypes.new(token, self.uri)
      self.employees           = Wonde::Employees.new(token, self.uri)
      self.events              = Wonde::Events.new(token, self.uri)
      self.groups              = Wonde::Groups.new(token, self.uri)
      self.lessons             = Wonde::Lessons.new(token, self.uri)
      self.lessonAttendance    = Wonde::LessonAttendance.new(token, self.uri)
      self.attendanceSummaries = Wonde::AttendanceSummaries.new(token, self.uri)
      self.medicalConditions   = Wonde::MedicalConditions.new(token, self.uri)
      self.medicalEvents       = Wonde::MedicalEvents.new(token, self.uri)
      self.medicalNotes        = Wonde::MedicalNotes.new(token, self.uri)
      self.periods             = Wonde::Periods.new(token, self.uri)
      self.photos              = Wonde::Photos.new(token, self.uri)
      self.rooms               = Wonde::Rooms.new(token, self.uri)
      self.students            = Wonde::Students.new(token, self.uri)
      self.studentsPreAdmission            = Wonde::StudentsPreAdmission.new(token, self.uri)
      self.subjects            = Wonde::Subjects.new(token, self.uri)
    end

    def pending(includes = Array.new(), parameters = Array.new())
      self.uri = @@uri + 'pending/'
      return self.all(includes, parameters)
    end

    def search(includes = Hash.new(), parameters = Hash.new())
        self.uri = @@uri + 'all/'
        return self.all(includes, parameters)
    end

    def get(id, includes = Array.new(), parameters = Array.new())
        self.uri = @@uri
        school = super(id, includes, parameters)
        return school
    end

  end
end
