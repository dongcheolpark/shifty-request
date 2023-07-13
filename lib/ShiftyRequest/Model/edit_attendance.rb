# frozen_string_literal: true

module ShiftyRequest
  module Model
    class EditAttendance
      attr_reader :original_attendance
      attr_reader :clock_in_time
      attr_reader :clock_out_time

      def initialize(original_attendance)
        return nil if original_attendance.proper_time?
        @original_attendance = original_attendance


      end
    end
  end
end
