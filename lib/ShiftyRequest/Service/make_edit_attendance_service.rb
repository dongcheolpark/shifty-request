# frozen_string_literal: true

module ShiftyRequest
  module Service
    class MakeEditAttendanceService
      def run(attendances:)
        attendances.map do |attendance|
          Model::EditAttendance(attendance)
        end.compact
      end
    end
  end
end
