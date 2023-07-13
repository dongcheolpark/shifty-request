# frozen_string_literal: true

module ShiftyRequest
  module Model
    class EditAttendance
      attr_reader :original_attendance

      def initialize(original_attendance)
        @original_attendance = original_attendance
      end

      def get_adjusted_clock_time
        return nil if original_attendance.proper_time?
        result = ClockTime.new(original_attendance.clock_time.clock_in_time, original_attendance.clock_time.clock_out_time)
        overtime = original_attendance.clock_time.over_time
      end
    end
  end
end
