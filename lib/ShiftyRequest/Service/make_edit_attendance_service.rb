# frozen_string_literal: true

module ShiftyRequest
  module Service
    module MakeEditAttendanceService
      class << self
        def run(attendances:)
          attendances.map do |attendance|
            puts attendance.clock_time
            puts attendance.clock_time.proper_time?
            if attendance.clock_time.proper_time?
              next
            else
              Model::EditAttendance.new(attendance)
            end
          end.compact
        end
      end
    end
  end
end
