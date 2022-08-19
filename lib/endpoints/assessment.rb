module Wonde
  class Assessment < Endpoints
    attr_accessor :uri, :templates, :aspects, :marksheets, :results, :resultsets
    def initialize(token, id=false, endpoint = nil)
      super
      self.templates = Templates.new(token, self.uri, self.endpoint)
      self.aspects = Aspects.new(token, self.uri, self.endpoint)
      self.marksheets = MarkSheets.new(token, self.uri, self.endpoint)
      self.results = Results.new(token, self.uri, self.endpoint)
      self.resultsets = ResultSets.new(token, self.uri, self.endpoint)
    end

  end
end
