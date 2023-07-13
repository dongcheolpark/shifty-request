# frozen_string_literal: true

module ShiftyRequest
  module Model
    class EditAttendance
      attr_reader :original_attendance

      WORKING_HOURS = Rational(9 / 24)

      def initialize(original_attendance)
        @original_attendance = original_attendance
      end

      def get_adjusted_clock_time
        def align_working_hours_with_regular_working_hours
        end

        return nil if original_attendance.proper_time?

        overtime = original_attendance.clock_time - WORKING_HOURS
      end
    end
  end
end
