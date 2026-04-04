# frozen_string_literal: true

module Cerberus
  module Domain
    class Rule
      attr_reader :effect, :expression

      def initialize(effect:, expression:)
        @effect = effect
        @expression = expression
      end

      def evaluate(context)
        effect.to_sym if expression.evaluate(context)
      end
    end
  end
end
