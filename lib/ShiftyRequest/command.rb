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
      working_time = load_working_time
      puts '출퇴근 기록을 불러옵니다.'
      attendances = @load_attendance.call
      edit_attendances = @make_edit_attendance_service.run(attendances:, working_time:)
      puts edit_attendances
      puts '수정 요청 전송을 시작합니다.'
      # @edit_attendance.call(edit_attendances:, working_time:)
    end

    def load_working_time
      puts '정해진 출퇴근 시간을 가져옵니다.'
      ShiftyRequest::Model::WorkingTime.new(
        Time.parse(ENV['WORK_START_TIME']),
        Time.parse(ENV['WORK_FINISH_TIME']),
      )
    end
  end
end
