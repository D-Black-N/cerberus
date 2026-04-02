# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      module Models
        module Expressions
          class Node < Expression
            OPERATORS = { or: 'or', and: 'and' }.freeze

            has_many :children, class_name: "#{namespace}Expression", dependent: :destroy

            enum :operator, OPERATORS, prefix: true
          end
        end
      end
    end
  end
end
