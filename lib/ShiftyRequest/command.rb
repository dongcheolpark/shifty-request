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
      @make_edit_attendance_service = Service::MakeEditAttendanceService.new
      @argv = argv
    end

    def run
      puts '출퇴근 기록을 불러옵니다.'
      attendances = @load_attendance.call
      @make_edit_attendance_service.run(attendances:)
      puts '수정 요청 전송을 시작합니다.'
      @make_edit_attendance_service.call(@edit_attendance)
    end
  end
end
