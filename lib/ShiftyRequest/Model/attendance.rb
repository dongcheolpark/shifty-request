# frozen_string_literal: true
require 'date'

module ShiftyRequest
  module Model
    class Attendance
      attr_reader :attendance_id
      attr_reader :clock_in_time
      attr_reader :clock_out_time

      def initialize(dto)
        @attendance_id = dto[:attendance_id]
        @clock_in_time = DateTime.parse(dto[:clock_in_time])
        @clock_out_time = DateTime.parse(dto[:clock_out_time])
      end

      def proper_time?(start_at: DateTime.new(2000, 1, 1, 10, 0, 0, '+9'), end_at: DateTime.new(2000, 1, 1, 19, 0, 0, '+9'))
        @clock_in_time.strftime('%H%M%S%N') <= start_at.strftime('%H%M%S%N') && end_at.strftime('%H%M%S%N') <= @clock_out_time.strftime('%H%M%S%N')
      end
    end
  end
end
