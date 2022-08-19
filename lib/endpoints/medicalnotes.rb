module Wonde
  class MedicalNotes < Endpoints
    @@uri = 'medical-notes/'
    def initialize(token, id=false, endpoint = nil)
      super(token, id, endpoint)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = self.uri.gsub("//", "/").chomp("/")
    end
  end
end
