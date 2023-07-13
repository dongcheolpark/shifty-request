# frozen_string_literal: true

require 'dotenv/load'

require_relative 'ShiftyRequest/command'
require_relative 'ShiftyRequest/edit_attendance'
require_relative 'ShiftyRequest/basic_header'

ShiftyRequest::Command.run(ARGV)
