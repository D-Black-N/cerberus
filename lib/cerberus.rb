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
require 'cerberus/application/resolver'
require 'cerberus/generators/migrations'
require 'cerberus/plugins'
require 'cerberus/configuration'

module Cerberus
  class NotAuthorized < StandardError; end

  class Base
    class << self
      def configuration
        @configuration ||= Cerberus::Configuration.new
      end

      def plugin(name, **opts)
        Cerberus::Plugins.load(configuration, name, **opts)
      end
    end
  end
end
