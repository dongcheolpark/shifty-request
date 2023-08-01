# frozen_string_literal: true

require 'date'

module ShiftyRequest
  module Request
    class LoadAttendance < APIRequest
      def url
        super + '/batch'
      end

      def request(edit_month:)
        response = HTTParty.post(url, headers: headers, body: body(edit_month:).to_json)

        parse_response_body(body: JSON.parse(response.body))
      end

      def parse_response_body(body:)
        attendances = body['attendances']
        attendances.map do |attendance|
          if attendance['clock_in_time'].nil? || attendance['clock_out_time'].nil?
            next
          else
            Model::Attendance.new(attendance.transform_keys(&:to_sym))
          end
        end.compact
      end

      def body(edit_month:)
        {
          'attendances': {
            'date_ranges': [[
              edit_month.beginning_of_month.iso8601,
              edit_month.end_of_month.iso8601,
            ]],
            'employee_ids': [ENV['EMPLOYEE_ID'].to_i],
          },
        }
      end
    end
  end
end
