# frozen_string_literal: true

module Cerberus
  # Represents an operand used in condition evaluation.
  #
  # An operand can represent:
  # - a literal value
  # - a value extracted from the evaluation context
  #
  # Operands are responsible for type awareness and value resolution
  # prior to comparison.
  #
  class Operand
    attr_reader :kind, :name, :value, :value_type

    def initialize(kind:, name: nil, value: nil, value_type: nil)
      @kind = kind
      @name = name
      @value = value
      @value_type = value_type
      @types = Types
    end

    def resolve(context)
      return types.cast(value, value_type) if kind == :constant

      context.fetch(kind).fetch(name)
    end
  end
end
