# frozen_string_literal: true

module ShiftyRequest
  module Service
    module MakeEditAttendanceService
      class << self
        def run(attendances:)
          attendances.map do |attendance|
            Model::EditAttendance.new(attendance)
          end.compact
        end
      end
    end
  end
end
