module Wonde
  class StudentsPreAdmission < Endpoints
    @@uri = 'students-pre-admission/'
    def initialize(token, id=false)
      super(token, id)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = self.uri.gsub("//", "/")
    end
  end
end
