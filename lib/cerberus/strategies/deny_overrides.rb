# frozen_string_literal: true

module Cerberus
  module Strategies
    # Rule-combining strategy: deny-overrides.
    #
    # Evaluates rules sequentially and returns:
    # - :deny if at least one rule evaluates to :deny
    # - :permit if no denies were found but at least one rule evaluates to :permit
    # - nil if no rules are applicable
    #
    # Evaluation is short-circuited on the first :deny.
    #
    class DenyOverrides
      def combine(rules, context)
        permit = nil

        rules.each do |rule|
          case rule.evaluate(context)
          when :deny
            return :deny
          when :permit
            permit = :permit
          end
        end

        permit
      end
    end
  end
end
