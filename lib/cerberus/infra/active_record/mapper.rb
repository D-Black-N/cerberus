# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      class Mapper
        attr_reader :domain_policy, :domain_rule, :builder

        def initialize(domain_policy:, domain_rule:, builder:)
          @domain_policy = domain_policy
          @domain_rule   = domain_rule
          @builder       = builder
        end

        def call(record)
          domain_policy.new(
            strategy: record.strategy,
            rules:    record.rules.map { |rule| build_rule(rule) }
          )
        end

        private

        def build_rule(rule)
          domain_rule.new(
            effect:     rule.effect,
            expression: builder.build(rule.expression)
          )
        end
      end
    end
  end
end
