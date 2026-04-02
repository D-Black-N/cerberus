# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      module Models
        class PolicyRule < ActiveRecord::Base
          belongs_to :policy, class_name: "#{namespaces}Policy"
          belongs_to :rule, class_name: "#{namespaces}Rule"
        end
      end
    end
  end
end
