# frozen_string_literal: true

module ShiftyRequest
  class Command
    class << self
      def run(argv)
        new(argv).run
      rescue => e
        puts e.message
      end
    end
    def initialize(argv)
      @edit_attendance = Request::EditAttendance.new
      @load_attendance = Request::LoadAttendance.new
      @make_edit_attendance_service = Service::MakeEditAttendanceService.new
      @argv = argv
    end

    def run
      edit_month = load_edit_month

      working_time = load_working_time
      attendances = load_attendances_history(working_time:, edit_month:)
      edit_attendances =  @make_edit_attendance_service.run(attendances:, working_time:)
      puts edit_attendances

      puts '해당 기록을 수정하시겠습니까? (Y/N)'
      answer = gets.chomp
      if answer == 'Y' || answer == 'y'
        send_edit_request(working_time:, edit_attendances:)
      end
    end

    def load_edit_month
      puts '수정할 출퇴근 기록의 기간을 선택해주세요.'
      puts "1. 저번 달 (#{Date.today.prev_month.strftime("%Y년 %m월")})"
      puts "2. 이번 달 (#{Date.today.strftime("%Y년 %m월")})"
      answer = gets.chomp

      result = if answer == '1'
        Time.now.prev_month
      elsif answer == '2'
        Time.now.beginning_of_month
      else
        puts '잘못된 입력입니다.'
        load_edit_month
      end
      result
    end

    def load_working_time
      puts '정해진 출퇴근 시간을 가져옵니다.'
      ShiftyRequest::Model::WorkingTime.new(
        Time.parse(ENV['WORK_START_TIME']),
        Time.parse(ENV['WORK_FINISH_TIME']),
      )
    end

    def load_attendances_history(working_time:, edit_month:)
      puts '출퇴근 기록을 불러옵니다.'
      @load_attendance.request(edit_month:)
    end

    def send_edit_request(edit_attendances:, working_time:)
      puts '수정 요청 전송을 시작합니다.'
      @edit_attendance.call(edit_attendances:, working_time:)
    end
  end
end
