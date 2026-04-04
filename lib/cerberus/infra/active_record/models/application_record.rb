# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      module Models
        class ApplicationRecord < ::ActiveRecord::Base
          self.abstract_class = true
          self.table_name_prefix = 'cerberus_'

          def self.namespace
            name.gsub(/\w+\z/, '')
          end
        end
      end
    end
  end
end
