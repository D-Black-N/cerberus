# frozen_string_literal: true

module Cerberus
  module Strategies
    # Rule-combining strategy: permit-unless-deny.
    #
    # Returns :deny if at least one rule denies.
    # Otherwise returns :permit.
    #
    class PermitUnlessDeny
      def combine(rules, context)
        rules.any? { |rule| rule.evaluate(context) == :deny } ? :deny : :permit
      end
    end
  end
end
