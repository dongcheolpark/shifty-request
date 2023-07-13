# frozen_string_literal: true
require 'date'

module ShiftyRequest
  module Model
    class ClockTime
      attr_reader :clock_in_time
      attr_reader :clock_out_time

      WORKING_HOURS = Rational(9, 24)

      def initialize(clock_in_time, clock_out_time)
        @clock_in_time = clock_in_time.is_a?(DateTime) ? clock_in_time : DateTime.parse(clock_in_time)
        @clock_out_time = clock_out_time.is_a?(DateTime) ? clock_out_time : DateTime.parse(clock_out_time)
      end

      def proper_time?(start_at: DateTime.new(2000, 1, 1, 10, 0, 0, '+9'), end_at: DateTime.new(2000, 1, 1, 19, 0, 0, '+9'))
        @clock_in_time.strftime('%H%M%S%N') <= start_at.strftime('%H%M%S%N') && end_at.strftime('%H%M%S%N') <= @clock_out_time.strftime('%H%M%S%N')
      end

      def over_time
        work_time - WORKING_HOURS
      end

      def work_time
        clock_out_time - clock_in_time
      end

      def align_to_start_time(start_at: DateTime.new(1, 1, 1, 10, 0, 0, '+9'))
        start_at = DateTime.new(@clock_in_time.year, @clock_in_time.month, @clock_in_time.day, start_at.hour, start_at.min, start_at.sec, '+9')
        gap = start_at - @clock_in_time
        self + gap
      end

      def +(other)
        ClockTime.new(@clock_in_time + other, @clock_out_time + other)
      end
    end
  end
end
