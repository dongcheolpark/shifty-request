# frozen_string_literal: true

module ShiftyRequest
  module Model
    class WorkingTime
      attr_reader :in_time
      attr_reader :out_time
      attr_reader :working_hours

      def initialize(in_time, out_time)
        @in_time = in_time.is_a?(Time) ? in_time : Time.parse(in_time)
        @out_time = out_time.is_a?(Time) ? out_time : Time.parse(out_time)
        @working_hours = out_time - in_time
      end
    end
  end
end
