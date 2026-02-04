# frozen_string_literal: true

module Cerberus
  # Represents an authorization policy.
  #
  # A policy groups multiple rules under a single action and resource scope
  # and defines how rule evaluation results are combined into a final decision.
  #
  # The combining behavior is delegated to a strategy object, allowing
  # different decision semantics such as permit-overrides or deny-overrides.
  #
  class Policy
    attr_reader :action, :entity, :rules, :strategy

    def initialize(action:, entity:, rules:, strategy: Cerberus::Strategies::PermitOverrides)
      @action = action
      @entity = entity
      @rules = rules
      @strategy = strategy
    end

    def evaluate(context)
      strategy.combine(rules, context)
    end
  end
end
