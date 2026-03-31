# frozen_string_literal: true

module Cerberus
  module Domain
    module Strategies
      class PermitOverrides
        def self.combine(rules, context)
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
end
