# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      class Builder
        def initialize(**args)
          @node_model       = args.fetch(:node_model, Models::Expressions::Node)
          @condition_model  = args.fetch(:condition_model, Models::Expressions::Condition)
          @domain_node      = args.fetch(:domain_node, Domain::Node)
          @domain_condition = args.fetch(:domain_condition, Domain::Condition)
          @domain_operand   = args.fetch(:domain_operand, Domain::Operand)
        end

        def build(record)
          build_record(record)
        end

        private

        attr_reader :node_model, :condition_model, :domain_node, :domain_condition, :domain_operand

        def build_record(record)
          case record
          when node_model
            build_node(record)
          when condition_model
            build_condition(record)
          end
        end

        def build_node(node)
          domain_node.new(
            operator: node.operator,
            children: node.children.map { |child| build_record(child) }
          )
        end

        def build_condition(condition)
          domain_condition.new(
            left:     build_operand(condition.left),
            operator: condition.operator,
            right:    build_operand(condition.right)
          )
        end

        def build_operand(operand)
          domain_operand.new(
            kind:       operand.kind,
            name:       operand.name,
            value:      operand.value,
            value_type: operand.value_type
          )
        end
      end
    end
  end
end
