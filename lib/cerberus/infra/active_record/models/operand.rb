# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      module Models
        class Operand < ApplicationRecord
          KINDS = {
            subject:  'subject',
            resource: 'resource',
            env:      'env',
            constant: 'constant'
          }.freeze

          VALUE_TYPES = {
            string:   'string',
            integer:  'integer',
            float:    'float',
            boolean:  'boolean',
            time:     'time',
            date:     'date',
            datetime: 'datetime',
            json:     'json',
            nil:      'nil'
          }.freeze

          has_many :left_conditions,
                   class_name: "#{namespace}Expressions::Condition",
                   inverse_of: :left_operand,
                   dependent:  :restrict_with_exception
          has_many :right_conditions,
                   class_name: "#{namespace}Expressions::Condition",
                   inverse_of: :right_operand,
                   dependent:  :restrict_with_exception

          enum :kind, KINDS, prefix: true
          enum :value_type, VALUE_TYPES, prefix: true
        end
      end
    end
  end
end
