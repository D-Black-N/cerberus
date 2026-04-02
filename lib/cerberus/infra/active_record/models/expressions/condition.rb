# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      module Models
        module Expressions
          class Condition < Expression
            OPERATORS = { eq: '==', neq: '!=', gt: '>', gteq: '>=', lt: '<', lteq: '<=' }.freeze

            belongs_to :left_operand, class_name: "#{namespace}Operand"
            belongs_to :right_operand, class_name: "#{namespace}Operand"

            enum :operator, OPERATORS
          end
        end
      end
    end
  end
end
