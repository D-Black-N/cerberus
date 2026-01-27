# frozen_string_literal: true

require_relative 'cerberus/version'

# Core files
require 'cerberus/rule'
require 'cerberus/matcher'
require 'cerberus/condition'
require 'cerberus/operand'

module Cerberus
  class Error < StandardError; end
  # Your code goes here...
end
