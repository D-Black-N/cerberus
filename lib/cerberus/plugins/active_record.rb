# frozen_string_literal: true

module Cerberus
  class Plugins
    class ActiveRecord
      class << self
        def apply(config, **)
          load_dependencies

          config.resolver = Application::Resolver.new(
            repository: Infra::ActiveRecord::Repository.new(
              model: Infra::ActiveRecord::Models::Policy
            ),
            mapper:     Infra::ActiveRecord::Mapper.new(
              domain_policy: Domain::Policy,
              domain_rule:   Domain::Rule,
              builder:       Infra::ActiveRecord::Builder.new
            )
          )
        end

        private

        def load_dependencies
          require 'active_record'
          require_relative '../infra/active_record/models/application_record'
          require_relative '../infra/active_record/repository'
          require_relative '../infra/active_record/builder'
          require_relative '../infra/active_record/mapper'
          require_relative '../infra/active_record/models/policy'
          require_relative '../infra/active_record/models/rule'
          require_relative '../infra/active_record/models/policy_rule'
          require_relative '../infra/active_record/models/operand'
          require_relative '../infra/active_record/models/expression'
          require_relative '../infra/active_record/models/expressions/node'
          require_relative '../infra/active_record/models/expressions/condition'
        end
      end
    end
  end
end
