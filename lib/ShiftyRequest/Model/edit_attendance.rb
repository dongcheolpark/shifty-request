# frozen_string_literal: true

module ShiftyRequest
  module Model
    class EditAttendance
      attr_reader :original_attendance

      def initialize(original_attendance)
        @original_attendance = original_attendance
      end

      def adjusted_clock_time(working_time)
        move_randomly_for_the_excess_time = ->(result) do
          get_random_offset = ->(overtime) do
            min = (overtime * 24 * 60).to_i
            random_min = rand(0..min)
            Rational(random_min, 24 * 60)
          end

          overtime = original_attendance.clock_time.over_time
          if overtime.positive?
            result -= get_random_offset.call(overtime)
          end
          result
        end

        original_clock_time = original_attendance.clock_time

        return if original_clock_time.proper_time?(working_time)

        result = original_clock_time
          .get_time_aligned_by_start_time

        result = move_randomly_for_the_excess_time.call(result)
        result
      end

      def to_s(working = nil)
        result = "origin_attendance: #{original_attendance}"
        result += "clock_time: #{adjusted_clock_time(working)}" unless working.nil?
        result
      end
    end
  end
end
