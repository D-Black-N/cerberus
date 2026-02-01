# frozen_string_literal: true

module Cerberus
  # Represents a single boolean condition.
  #
  # A condition compares two operands using a comparison operator
  # and evaluates to true or false in a given context.
  #
  # Conditions are the atomic elements of a rule condition tree
  # and are evaluated within a Node.
  #
  class Condition
    attr_reader :left, :right, :operator

    def initialize(left:, right:, operator:)
      @left = left
      @right = right
      @operator = operator
    end

    def evaluate(context)
      left.resolve(context).public_send(
        operator,
        right.resolve(context)
      )
    end
  end
end
