# frozen_string_literal: true

module Cerberus
  module Application
    class Authorizer
      attr_reader :resolver

      def initialize(resolver:)
        @resolver = resolver
      end

      def authorized?(action:, subject: nil, resource: nil, env: {})
        policy = resolver.execute(action)
        policy&.evaluate(subject:, resource:, env:) == :permit
      end

      def authorize!(action:, **args)
        authorized?(action:, **args) || (raise NotAuthorized, "Not authorized to #{action}")
      end
    end
  end
end
