# frozen_string_literal: true
require 'httparty'

module ShiftyRequest
  class EditAttendance
    def initialize
      @url = 'https://shiftee.io/api/request'
      @headers = {
        "Content-Type": 'application/json',
        "Expires": 'Sat, 01 Jan 2000 00:00:00 GMT',
        "Cookie": ENV['COOKIE'],
        "Accept-Encoding": 'gzip, deflate, br',
        "Accept-Language": 'ko,en-US;q=0.9,en;q=0.8,ko-KR;q=0.7,ja;q=0.6',
        "Accept": '*/*',
      }
      @body =
        {
          "approval_sequence": [
            1,
          ],
          "requested_employee_ids_sequence": [
            [
              686455,
            ],
          ],
          "followed_employee_ids_sequence": [
            [],
          ],
          "data": {
            "requestType": 'edit_attendance',
            "attendance_id": 56756437,
            "previous_clock_in_time": '2023-05-11T09:13:14+09:00',
            "previous_clock_out_time": '2023-05-11T18:34:54+09:00',
            "clock_in_time": '2023-05-11T09:46:14+09:00',
            "clock_out_time": '2023-05-11T19:05:54+09:00',
            "tags": [
              'past_attendance',
            ],
            "note": '10 to 7',
          },
        }
    end

    def call
      puts @headers
      response = HTTParty.post(@url, headers: @headers)
      puts response
    end
  end
end
