# frozen_string_literal: true

module Cerberus
  module Infra
    module ActiveRecord
      class Repository
        attr_reader :model

        def initialize(model:)
          @model = model
        end

        def find(action:, resource_type:)
          model.find_by(action:, resource_type:)
        end
      end
    end
  end
end
