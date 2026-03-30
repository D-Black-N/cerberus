# frozen_string_literal: true

module Cerberus
  module Domain
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
end
