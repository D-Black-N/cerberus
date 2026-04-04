# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      module Models
        class Rule < ApplicationRecord
          EFFECTS = { allow: 'allow', deny: 'deny' }.freeze

          has_many :policy_rules, class_name: "#{namespace}PolicyRule", dependent: :destroy
          has_many :policies, class_name: "#{namespace}Policy", through: :policy_rules
          has_one :expression, class_name: "#{namespace}Expression", dependent: :destroy

          enum :effect, EFFECTS

          validates :effect, presence: true
        end
      end
    end
  end
end
