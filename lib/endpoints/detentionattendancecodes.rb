module Wonde
  class DetentionAttendanceCodes < Endpoints
    @@uri = 'detention-attendance-codes/'
    def initialize(token, id=false)
      super(token, id)
      self.endpoint = 'https://api-beta.edge.wonde.com/v1.0/' # remove line when out of beta
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = self.uri.gsub("//", "/").chomp("/")
    end
  end
end
