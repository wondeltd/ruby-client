module Wonde
  class DetentionTypes < Endpoints
    @@uri = 'detention-types/'
    def initialize(token, id=false)
      super(token, id)
      self.endpoint = 'https://api-beta.edge.wonde.com/v1.0/' # remove line when out of beta
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = self.uri.gsub("//", "/").chomp("/")
    end
  end
end
