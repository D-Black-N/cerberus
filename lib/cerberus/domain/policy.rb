# frozen_string_literal: true

require "cerberus/domain/strategies/deny_overrides"
require "cerberus/domain/strategies/deny_unless_permit"
require "cerberus/domain/strategies/permit_overrides"
require "cerberus/domain/strategies/permit_unless_deny"

module Cerberus
  module Domain
    class Policy
      attr_reader :rules, :strategy

      STRATEGIES = {
        permit_overrides:   Strategies::PermitOverrides,
        permit_unless_deny: Strategies::PermitUnlessDeny,
        deny_overrides:     Strategies::DenyOverrides,
        deny_unless_permit: Strategies::DenyUnlessPermit,
      }.freeze

      def initialize(rules:, strategy: :permit_overrides)
        @rules = rules
        @strategy = strategy.to_sym
      end

      def evaluate(context)
        STRATEGIES.fetch(strategy).combine(rules, context)
      end
    end
  end
end
