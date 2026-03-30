# frozen_string_literal: true

module Cerberus
  module Domain
    module Strategies
      class DenyOverrides
        def self.combine(rules, context)
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
end
