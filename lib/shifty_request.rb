# frozen_string_literal: true

require 'dotenv/load'

module ShiftyRequest
end

require_relative 'ShiftyRequest/command'
require_relative 'ShiftyRequest/edit_attendance'

ShiftyRequest::Command.run(ARGV)
