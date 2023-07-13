# frozen_string_literal: true

module ShiftyRequest
  module Model
    class Attendance
      attr_reader :attendance_id
      attr_reader :clock_in_time
      attr_reader :clock_out_time

      def initialize(dto)
        @attendance_id = dto['attendance_id']
        @clock_in_time = DateTime.parse(dto['clock_in_time'])
        @clock_out_time = DateTime.parse(dto['clock_out_time'])
      end
    end
  end
end
