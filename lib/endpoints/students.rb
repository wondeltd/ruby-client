module Wonde
  class Students < Endpoints
    @@uri = 'students/'
    def initialize(token, id=false, endpoint = nil)
      super(token, id, endpoint)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = self.uri.gsub("//", "/")
    end
  end
end
