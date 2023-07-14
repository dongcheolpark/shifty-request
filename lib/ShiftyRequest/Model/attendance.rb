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
        "출퇴근 기록 ID: #{attendance_id}, 출근 시간: #{clock_time.in_time.localtime}, 퇴근 시간: #{clock_time.out_time.localtime}"
      end
    end
  end
end
