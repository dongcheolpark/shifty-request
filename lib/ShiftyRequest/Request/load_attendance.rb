# frozen_string_literal: true

module ShiftyRequest
  module Request
    class LoadAttendance < APIRequest
      def url
        super + '/batch'
      end

      def call
        response = HTTParty.post(url, headers: headers, body: body.to_json)

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

      def body
        {
          'attendances': {
            'date_ranges': [['2023-06-01T00:00:00+09:00', '2023-06-30T23:59:59+09:00']],
            'employee_ids': [ENV['EMPLOYEE_ID'].to_i],
          },
        }
      end
    end
  end
end
