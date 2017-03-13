module Wonde
  class ValidationError < StandardError
    def initialize(msg="Unknown Validation Error")
        super
    end
  end
end
