module Wonde
  class InvalidTokenException < StandardError
    def initialize(msg="Unknown InvalidTokenException Error")
        super
    end
  end
end
