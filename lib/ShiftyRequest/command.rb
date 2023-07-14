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
      edit_attendances = @make_edit_attendance_service.run(attendances:, working_time:)
      puts '수정 요청 전송을 시작합니다.'
      @make_edit_attendance_service.call(edit_attendances:, working_time:)
    end

    def working_time
      ShiftyRequest::Model::WorkingTime.new(
        Time.new(1, 1, 1, 10, 0, 0, '+09'),
        Time.new(1, 1, 1, 19, 0, 0, '+09'),
      )
    end
  end
end
