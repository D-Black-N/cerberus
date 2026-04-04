# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      module Models
        class PolicyRule < ApplicationRecord
          belongs_to :policy, class_name: "#{namespace}Policy"
          belongs_to :rule, class_name: "#{namespace}Rule"
        end
      end
    end
  end
end
