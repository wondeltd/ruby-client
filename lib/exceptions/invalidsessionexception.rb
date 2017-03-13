module Wonde
  class InvalidSessionException < StandardError
    def initialize(msg="Unknown InvalidSessionException Error")
        super
    end
  end
end
