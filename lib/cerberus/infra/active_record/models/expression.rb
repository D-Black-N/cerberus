# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      module Models
        class Expression < ApplicationRecord
          belongs_to :rule, class_name: "#{namespace}Rule"
          belongs_to :parent, class_name: "#{namespace}Expression"
        end
      end
    end
  end
end
