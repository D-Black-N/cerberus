# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      class Mapper
        attr_reader :policy_class, :rule_class, :builder, :strategies

        def initialize(policy_class:, rule_class:, builder:, strategies:)
          @policy_class = policy_class
          @rule_class   = rule_class
          @builder      = builder
          @strategies   = strategies
        end

        def call(record)
          policy_class.new(
            strategy: record.strategy,
            rules:    record.rules.map { |rule| build_rule(rule) }
          )
        end

        private

        def build_rule(rule)
          rule_class.new(
            effect:     rule.effect,
            expression: builder.build(rule.expression)
          )
        end
      end
    end
  end
end
