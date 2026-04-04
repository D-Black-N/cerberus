# frozen_string_literal: true

module Cerberus
  module Application
    class Authorizer
      attr_reader :resolver

      def initialize(resolver:)
        @resolver = resolver
      end

      def authorized?(action:, resource_type:, subject: nil, resource: nil, env: {})
        policy = resolver.resolve(action:, resource_type:)
        policy&.evaluate(subject:, resource:, env:) == :permit
      end

      def authorize!(action:, resource_type:, **args)
        authorized?(action:, resource_type:, **args) ||
          (raise NotAuthorized, "Not authorized #{resource_type} to #{action}")
      end
    end
  end
end
