# frozen_string_literal: true

require 'date'
require 'active_support/all'

module ShiftyRequest
  module Model
    class ClockTime
      attr_reader :in_time
      attr_reader :out_time

      def initialize(in_time, out_time)
        @in_time = in_time.is_a?(Time) ? in_time : Time.parse(in_time)
        @out_time = out_time.is_a?(Time) ? out_time : Time.parse(out_time)
      end

      def proper_time?(working_time)
        @in_time.only_time <= working_time.in_time.only_time && working_time.out_time.only_time <= @out_time.only_time
      end

      def over_time(working_time)
        work_time - working_time.working_hours
      end

      def work_time
        out_time - in_time
      end

      def get_time_aligned_by_start_time(start_at: Time.new(1, 1, 1, 10, 0, 0, '+09'))
        start_at = Time.new(
          @in_time.year,
          @in_time.month,
          @in_time.day,
          start_at.hour,
          start_at.min,
          start_at.sec,
          '+09',
        )
        gap = start_at - @in_time
        self + gap
      end

      def +(other)
        ClockTime.new(@in_time + other, @out_time + other)
      end

      def -(other)
        ClockTime.new(@in_time - other, @out_time - other)
      end

      def to_s
        "\"in_time : #{in_time.getlocal}, out_time : #{out_time.getlocal}\, work_time : #{(work_time / (60 * 60)).round(2)} 시간\""
      end
    end
  end
end
