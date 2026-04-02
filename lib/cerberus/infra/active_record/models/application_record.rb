# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      module Models
        class ApplicationRecord < ActiveRecord::Base
          def self.namespace
            name.gsub(/\w+\z/, '')
          end
        end
      end
    end
  end
end
