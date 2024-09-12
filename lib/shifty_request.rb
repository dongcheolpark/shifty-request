# frozen_string_literal: true
require 'dotenv/load'

require_relative 'dependencies'

ShiftyRequest::Command.run(ARGV)
