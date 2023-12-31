# frozen_string_literal: true

require 'httparty'
require 'json'

module ShiftyRequest
  module Request
    class EditAttendance < APIRequest
      def url
        super + '/request'
      end

      def call(edit_attendances:, working_time:)
        edit_attendances.each do |attendance|
          puts body(attendance, working_time)
          response = HTTParty.post(url, headers: headers, body: body(attendance, working_time))
          puts response
        end
      end

      def body(edit_attendance, working_time)
        edit_time = edit_attendance.adjusted_clock_time(working_time)
        {
          'approval_sequence': [
            1,
          ],
          'requested_employee_ids_sequence': [
            [
              ENV['REQUESTED_EMPLOYEE_ID']&.to_i,
            ],
          ],
          'followed_employee_ids_sequence': [
            [],
          ],
          data: {
            'requestType': 'edit_attendance',
            'attendance_id': edit_attendance.original_attendance.attendance_id,
            'previous_clock_in_time': edit_attendance.original_attendance.clock_time.in_time,
            'previous_clock_out_time': edit_attendance.original_attendance.clock_time.out_time,
            'clock_in_time': edit_time.in_time,
            'clock_out_time': edit_time.out_time,
            'tags': [
              'past_attendance',
            ],
            'note': "#{working_time.in_time.localtime.hour} to #{working_time.out_time.localtime.hour}",
          },
        }.to_json
      end
    end
  end
end
