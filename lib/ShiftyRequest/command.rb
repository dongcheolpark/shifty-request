# frozen_string_literal: true

module ShiftyRequest
  class Command
    class << self
      def run(argv)
        new(argv).run
      end
    end
    def initialize(argv)
      @edit_attendance = Request::EditAttendance.new
      @load_attendance = Request::LoadAttendance.new
      @argv = argv
    end

    def run
      puts '출퇴근 기록을 불러옵니다.'
      attendances = @load_attendance.call
      Service::MakeEditAttendanceService.run(attendances:)
      puts '수정 요청 전송을 시작합니다.'
      # @edit_attendance.call
    end
  end
end
