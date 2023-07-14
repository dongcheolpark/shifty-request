# frozen_string_literal: true

module ShiftyRequest
  module Service
    class MakeEditAttendanceService
      def run(attendances:)
        attendances.map do |attendance|
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
