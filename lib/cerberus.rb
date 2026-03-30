# frozen_string_literal: true

require_relative "cerberus/version"

require "time"
require "date"
require "json"

require "cerberus/types"
require "cerberus/domain/operand"
require "cerberus/domain/condition"
require "cerberus/domain/node"
require "cerberus/domain/rule"
require "cerberus/domain/policy"

require "cerberus/application/authorizer"

module Cerberus
  class NotAuthorized < StandardError; end
  # Your code goes here...
end
