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
    attr_reader :kind, :name, :value, :value_type, :types

    def initialize(kind:, name: nil, value: nil, value_type: nil, types: Types)
      @kind = kind.to_sym
      @name = name
      @value = value
      @value_type = value_type
      @types = types
    end

    def resolve(context)
      return types.cast(value, value_type) if kind == :constant

      keys = name.is_a?(String) ? name.split(".") : Array(name)
      object = context.fetch(kind)

      keys.reduce(object) do |memo, key|
        memo.is_a?(Hash) ? memo.fetch(key.to_sym) : memo.public_send(key)
      end
    end
  end
end
