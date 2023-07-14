# frozen_string_literal: true

class Time
  def only_time
    utc.strftime('%H%M%S%N')
  end
end
