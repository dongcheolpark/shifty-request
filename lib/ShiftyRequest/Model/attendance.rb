# frozen_string_literal: true
require 'date'

module ShiftyRequest
  module Model
    class Attendance
      attr_reader :attendance_id
      attr_reader :clock_time

      def initialize(dto)
        @attendance_id = dto[:attendance_id]
        @clock_time = ClockTime.new(dto[:clock_in_time], dto[:clock_out_time])
      end

      def to_s
        "id: #{attendance_id}, clock_time: #{clock_time}"
      end
    end
  end
end
