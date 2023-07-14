# frozen_string_literal: true

require "date"

class DateTime
  def only_time
    utc.strftime("%H%M%S%N")
  end
end
