# frozen_string_literal: true

module Cerberus
  module Domain
    module Strategies
      class DenyUnlessPermit
        def self.combine(rules, context)
          rules.any? { |rule| rule.evaluate(context) == :permit } ? :permit : :deny
        end
      end
    end
  end
end
