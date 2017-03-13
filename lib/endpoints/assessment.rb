module Wonde
  class Assessment < Endpoints
    attr_accessor :uri, :templates, :aspects, :marksheets, :results, :resultsets
    def initialize(token, id=false)
      super
      self.templates = Templates.new(token, self.uri)
      self.aspects = Aspects.new(token, self.uri)
      self.marksheets = MarkSheets.new(token, self.uri)
      self.results = Results.new(token, self.uri)
      self.resultsets = ResultSets.new(token, self.uri)
    end

  end
end
