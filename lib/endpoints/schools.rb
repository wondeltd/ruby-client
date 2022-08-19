module Wonde
  class Schools < Endpoints
    attr_accessor :uri, :achievements, :attendance, :behaviours, :classes,
                  :contacts, :counts, :employees, :groups, :lessons,
                  :lessonAttendance, :medicalConditions, :medicalEvents,
                  :medicalNotes, :periods, :photos, :rooms, :subjects, :students,
                  :assessment, :deletions, :events, :attendanceSummaries

    @@uri = 'schools/'

    def initialize(token, id=false, endpoint = nil)
      super(token, id, endpoint)

      self.token = token
      self.uri = @@uri

      if id
        self.uri = @@uri + id + '/'
        self.endpoint = "https://" + data.region.domain + "/v1.0/"
      end

      self.uri = self.uri.gsub("//", "/").chomp("/")

      self.achievements        = Wonde::Achievements.new(token, self.uri, self.endpoint)
      self.assessment          = Wonde::Assessment.new(token, self.uri, self.endpoint)
      self.attendance          = Wonde::Attendance.new(token, self.uri, self.endpoint)
      self.behaviours          = Wonde::Behaviours.new(token, self.uri, self.endpoint)
      self.classes             = Wonde::Classes.new(token, self.uri, self.endpoint)
      self.contacts            = Wonde::Contacts.new(token, self.uri, self.endpoint)
      self.counts              = Wonde::Counts.new(token, self.uri, self.endpoint)
      self.deletions           = Wonde::Deletions.new(token, self.uri, self.endpoint)
      self.employees           = Wonde::Employees.new(token, self.uri, self.endpoint)
      self.events              = Wonde::Events.new(token, self.uri, self.endpoint)
      self.groups              = Wonde::Groups.new(token, self.uri, self.endpoint)
      self.lessons             = Wonde::Lessons.new(token, self.uri, self.endpoint)
      self.lessonAttendance    = Wonde::LessonAttendance.new(token, self.uri, self.endpoint)
      self.attendanceSummaries = Wonde::AttendanceSummaries.new(token, self.uri, self.endpoint)
      self.medicalConditions   = Wonde::MedicalConditions.new(token, self.uri, self.endpoint)
      self.medicalEvents       = Wonde::MedicalEvents.new(token, self.uri, self.endpoint)
      self.medicalNotes        = Wonde::MedicalNotes.new(token, self.uri, self.endpoint)
      self.periods             = Wonde::Periods.new(token, self.uri, self.endpoint)
      self.photos              = Wonde::Photos.new(token, self.uri, self.endpoint)
      self.rooms               = Wonde::Rooms.new(token, self.uri, self.endpoint)
      self.students            = Wonde::Students.new(token, self.uri, self.endpoint)
      self.subjects            = Wonde::Subjects.new(token, self.uri, self.endpoint)
    end

    # Load this object's data
    def data
      @data ||= begin
        response = getUrl(self.endpoint + self.uri).body

        JSON.parse(response, object_class: OpenStruct).data
      end
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
