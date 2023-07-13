# frozen_string_literal: true

module ShiftyRequest
  class LoadAttendance < APIRequest
    def url
      super + '/batch'
    end

    def call
      response = HTTParty.post(url, headers: headers, body: body.to_json)
      puts response
    end

    def body
      {
        "attendances": {
          "date_ranges": [['2023-06-24T00:00:00+09:00', '2023-08-07T23:59:59+09:00']],
          "employee_ids": [713220],
        },
      }
    end
  end
end
