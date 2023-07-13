# frozen_string_literal: true

module ShiftyRequest
  class Command
    def initialize(argv)
      @request = EditAttendance.new
      @argv = argv
    end

    def self.run(argv)
      new(argv).run
    end

    def run
      puts '수정 요청 전송을 시작합니다.'

      @request.call
    end
  end
end
