# frozen_string_literal: true

module Cerberus
  module Strategies
    # Rule-combining strategy: deny-unless-permit.
    #
    # Returns :permit if at least one rule permits.
    # Otherwise returns :deny.
    #
    class DenyUnlessPermit
      def self.combine(rules, context)
        rules.any? { |rule| rule.evaluate(context) == :permit } ? :permit : :deny
      end
    end
  end
end
