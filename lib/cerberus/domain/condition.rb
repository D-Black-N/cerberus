# frozen_string_literal: true

module Cerberus
  module Domain
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
end
