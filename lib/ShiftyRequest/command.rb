# frozen_string_literal: true

module ShiftyRequest
  class Command
    def initialize(argv)
      @edit_attendance = EditAttendance.new
      @load_attendance = LoadAttendance.new
      @argv = argv
    end

    def self.run(argv)
      new(argv).run
    end

    def run
      puts '출퇴근 기록을 불러옵니다.'
      attendances = @load_attendance.call
      attendances.each { |a| puts a.attendance_id }
      puts '수정 요청 전송을 시작합니다.'
      #@edit_attendance.call
    end
  end
end
