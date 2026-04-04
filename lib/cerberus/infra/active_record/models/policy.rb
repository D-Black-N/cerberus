# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      module Models
        class Policy < ApplicationRecord
          STRATEGIES = {
            permit_overrides:   'permit_overrides',
            permit_unless_deny: 'permit_unless_deny',
            deny_overrides:     'deny_overrides',
            deny_unless_permit: 'deny_unless_permit'
          }.freeze

          has_many :policy_rules, class_name: "#{namespace}PolicyRule", dependent: :destroy
          has_many :rules, class_name: "#{namespace}Rule", through: :policy_rules

          enum :strategy, STRATEGIES

          validates :action, :strategy, presence: true
        end
      end
    end
  end
end
