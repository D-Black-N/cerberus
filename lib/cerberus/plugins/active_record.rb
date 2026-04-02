# frozen_string_literal: true

module Cerberus
  module Plugins
    class ActiveRecord
      def self.load(config, **)
        require 'active_record'
        require 'cerberus/infra/active_record/**/*'

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
    end
  end
end
