# frozen_string_literal: true

module Cerberus
  module Domain
    module Strategies
      class PermitUnlessDeny
        def self.combine(rules, context)
          rules.any? { |rule| rule.evaluate(context) == :deny } ? :deny : :permit
        end
      end
    end
  end
end
