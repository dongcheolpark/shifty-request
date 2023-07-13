# frozen_string_literal: true

module ShiftyRequest
  module Model
    attr_reader :original_attendance
    attr_reader :clock_in_time
    attr_reader :clock_out_time

    class EditAttendance
      def initialize(original_attendance)
        @original_attendance = original_attendance
      end
    end
  end
end
