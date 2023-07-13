# frozen_string_literal: true

module ShiftyRequest
  module Model
    class EditAttendance
      attr_reader :original_attendance

      def initialize(original_attendance)
        @original_attendance = original_attendance
      end

      def get_adjusted_clock_time
        def move_randomly_for_the_excess_time(result)
          def get_random_offset(overtime)
            min = (overtime * 24 * 60).to_i
            random_min = rand(0..min)
            Rational(random_min, 24 * 60)
          end

          overtime = original_attendance.clock_time.over_time
          if overtime.positive?
            result -= get_random_offset(overtime)
          end
          result
        end

        original_clock_time = original_attendance.clock_time

        return nil if original_clock_time.proper_time?
        result = original_clock_time
          .get_time_aligned_by_start_time

        result = move_randomly_for_the_excess_time(result)
        result
      end
    end
  end
end
