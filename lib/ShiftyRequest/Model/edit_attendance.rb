# frozen_string_literal: true

module ShiftyRequest
  module Model
    class EditAttendance
      attr_reader :original_attendance

      def initialize(original_attendance)
        @original_attendance = original_attendance
      end

      def adjusted_clock_time(working_time)
        original_clock_time = original_attendance.clock_time

        return if original_clock_time.proper_time?(working_time)

        result = original_clock_time
          .get_time_aligned_by_start_time

        result = move_randomly_for_the_excess_time(result, working_time)
        result
      end

      def to_s(working = nil)
        result = "수정 전 출퇴근 기록: #{original_attendance}"
        result += "clock_time: #{adjusted_clock_time(working)}" unless working.nil?
        result
      end

      private

      def move_randomly_for_the_excess_time(clock_time, working_time)
        overtime = original_attendance.clock_time.over_time(working_time)
        overtime = overtime > 0 ? overtime : 3
        if overtime.positive?
          clock_time - get_random_offset(overtime)
        end
      end

      def get_random_offset(overtime)
        min = (overtime * 24 * 60).to_i
        random_min = rand(0..min)
        Rational(random_min, 24 * 60)
      end
    end
  end
end
