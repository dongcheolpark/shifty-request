# frozen_string_literal: true
require 'httparty'
require 'json'

module ShiftyRequest
  class EditAttendance
    def initialize
      @url = 'https://shiftee.io/api/request'
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
            "attendance_id": 56964689,
            "previous_clock_in_time": '2023-05-15T00:48:31.654Z',
            "previous_clock_out_time": '2023-05-15T09:51:37.766Z',
            "clock_in_time": '2023-05-15T00:55:31.654Z',
            "clock_out_time": '2023-05-15T10:03:37.766Z',
            "tags": [
              'past_attendance',
            ],
            "note": '10 to 7',
          },
        }
    end

    def call
      response = HTTParty.post(@url, headers: BasicHeader.get, body: @body.to_json)
      puts response
    end
  end
end
