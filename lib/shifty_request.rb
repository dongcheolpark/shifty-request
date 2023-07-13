# frozen_string_literal: true

module ShiftyRequest
end

require_relative 'ShiftyRequest/command'

ShiftyRequest::Command.run(ARGV)
