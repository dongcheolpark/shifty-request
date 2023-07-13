# frozen_string_literal: true

require 'dotenv/load'

require_relative 'ShiftyRequest/Model/attendance'
require_relative 'ShiftyRequest/Model/clock_time'
require_relative 'ShiftyRequest/Model/edit_attendance'

require_relative 'ShiftyRequest/command'
require_relative 'ShiftyRequest/Request/api_request'
require_relative 'ShiftyRequest/Request/edit_attendance'
require_relative 'ShiftyRequest/Request/load_attendance'

ShiftyRequest::Command.run(ARGV)
