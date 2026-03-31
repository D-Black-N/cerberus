# frozen_string_literal: true

module Cerberus
  module Application
    # Policy Enforcement Point (PEP).
    # Responsible for resolving a policy and enforcing its decision.
    class Authorizer
      attr_reader :resolver

      def initialize(resolver:)
        @resolver = resolver
      end

      def authorized?(action:, subject: nil, resource: nil, env: {})
        policy = resolver.execute(action)
        policy&.evaluate(subject:, resource:, env:) == :permit
      end

      def authorized!(action:, **args)
        authorized?(action:, **args) || (raise NotAuthorized, "Not authorized to #{action}")
      end
    end
  end
end
