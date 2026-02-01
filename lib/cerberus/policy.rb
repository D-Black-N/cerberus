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
    attr_reader :action, :resource_type, :rules, :combining_algorithm

    def initialize(action:, resource_type:, rules:, combining_algorithm:)
      @action = action
      @resource_type = resource_type
      @rules = rules
      @combining_algorithm = combining_algorithm
    end

    def evaluate(context)
      combining_algorithm.combine(rules, context)
    end
  end
end
