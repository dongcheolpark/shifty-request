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

        result = change_clock_time_to_fit_working_time(original_clock_time, working_time)
          .get_time_aligned_by_start_time

        result = move_randomly_for_the_excess_time(result, working_time)
        result
      end

      def to_s(working_time = nil)
        result = "수정 전 출퇴근 기록: #{original_attendance}"
        result + "\n수정 후 출퇴근 기록 : #{adjusted_clock_time(working_time)}" unless working_time.nil?
      end

      private

      def change_clock_time_to_fit_working_time(clock_time, working_time)
        if clock_time.work_time < (working_time.working_hours * 2 / 3)
          working_time = working_time / 2
        end
        if clock_time.work_time >= working_time.working_hours
          clock_time
        else # 출퇴근 시간이 근무시간보다 짧을 때 근무시간에 맞춰 출퇴근 시간을 조정
          diff = working_time.working_hours - clock_time.work_time
          offset = 3 * 60 # 3분
          ClockTime.new(clock_time.in_time, clock_time.out_time + diff + offset)
        end
      end

      def move_randomly_for_the_excess_time(clock_time, working_time)
        overtime = clock_time.over_time(working_time)
        if overtime.positive?
          clock_time - get_random_offset(overtime)
        else
          clock_time
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
