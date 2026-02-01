# frozen_string_literal: true

module Cerberus
  module Strategies
    # Rule-combining strategy: permit-overrides.
    #
    # Evaluates rules sequentially and returns:
    # - :permit if at least one rule evaluates to :permit
    # - :deny if no permits were found but at least one rule evaluates to :deny
    # - nil if no rules are applicable
    #
    # Evaluation is short-circuited on the first :permit.
    #
    class PermitOverrides
      def combine(rules, context)
        deny = nil

        rules.each do |rule|
          case rule.evaluate(context)
          when :permit
            return :permit
          when :deny
            deny = :deny
          end
        end

        deny
      end
    end
  end
end
