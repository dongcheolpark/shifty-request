# frozen_string_literal: true
require 'httparty'
require 'json'

module ShiftyRequest
  module Request
    class EditAttendance < APIRequest
      def url
        super + '/request'
      end

      def call(edit_attendances)
        edit_attendances.each do |attendance|
          response = HTTParty.post(url, headers: headers, body: body(attendance))
          puts response
        end
      end

      def body(edit_attendance)
        edit_time = edit_attendance.get_adjusted_clock_time
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
          data: {
            "requestType": 'edit_attendance',
            "attendance_id": edit_attendance.original_attendance.attendance_id,
            "previous_clock_in_time": edit_attendance.original_attendance.clock_time.in_time.to_s,
            "previous_clock_out_time": edit_attendance.original_attendance.clock_time.out_time.to_s,
            "clock_in_time": edit_time.in_time.to_s,
            "clock_out_time": edit_time.out_time.to_s,
            "tags": [
              'past_attendance',
            ],
            "note": '10 to 7',
          },
        }.to_json
      end
    end
  end
end
