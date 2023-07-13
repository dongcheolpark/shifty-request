# frozen_string_literal: true
module ShiftyRequest
  module BasicHeader
    class << self
      def get
        headers = {
          "Content-Type": 'application/json',
          "Expires": 'Sat, 01 Jan 2000 00:00:00 GMT',
          "Cookie": ENV['COOKIE'],
          "Accept-Encoding": 'gzip, deflate, br',
          "Accept-Language": 'ko,en-US;q=0.9,en;q=0.8,ko-KR;q=0.7,ja;q=0.6',
          "Accept": '*/*',
        }
        return headers
      end
    end
  end
end
