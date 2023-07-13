# frozen_string_literal: true

require 'dotenv/load'

require_relative 'ShiftyRequest/command'
require_relative 'ShiftyRequest/edit_attendance'
require_relative 'ShiftyRequest/api_request'

ShiftyRequest::Command.run(ARGV)
