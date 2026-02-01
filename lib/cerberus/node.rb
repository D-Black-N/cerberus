# frozen_string_literal: true

module Cerberus
  # Represents a logical node within a rule condition tree.
  #
  # A node combines one or more child conditions or nodes
  # using a logical operator (e.g. AND, OR).
  #
  # Nodes allow building arbitrarily complex logical expressions
  # for rule applicability.
  #
  class Node
    attr_reader :operator, :children

    def initialize(operator:, children:)
      @operator = operator
      @children = children
    end

    def evaluate(context)
      return children.all? { |child| child.evaluate(context) } if operator == :and

      children.any? { |child| child.evaluate(context) }
    end
  end
end
