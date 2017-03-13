module Wonde
  class InvalidAttendanceException < StandardError
    def initialize(msg="Unknown InvalidAttendanceException Error")
        super
    end
  end
end
