# frozen_string_literal: true

module Cerberus
  # Represents a single authorization rule.
  #
  # A rule encapsulates a logical condition tree and an effect
  # that is returned when the rule is applicable.
  #
  # A rule evaluation may result in:
  # - :permit
  # - :deny
  # - nil (not applicable)
  #
  class Rule
    attr_reader :effect, :condition

    def initialize(effect:, condition:)
      @effect = effect
      @condition = condition
    end

    def evaluate(context)
      effect if condition.evaluate(context)
    end
  end
end
