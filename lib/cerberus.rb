# frozen_string_literal: true

require_relative 'cerberus/version'

require 'time'
require 'date'
require 'json'

require 'cerberus/infra/types'
require 'cerberus/domain/operand'
require 'cerberus/domain/condition'
require 'cerberus/domain/node'
require 'cerberus/domain/rule'
require 'cerberus/domain/policy'

require 'cerberus/application/authorizer'

module Cerberus
  class NotAuthorized < StandardError; end

  module ClassMethods
    def configuration
      @configuration ||= Configuration.new
    end

    def plugin(name, **opts)
      Plugins.load(self, name, **opts)
    end
  end

  extend ClassMethods
end
