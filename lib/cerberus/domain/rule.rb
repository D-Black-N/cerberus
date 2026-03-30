# frozen_string_literal: true

module Cerberus
  module Domain
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
end
