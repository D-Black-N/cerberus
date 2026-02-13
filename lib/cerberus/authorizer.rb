# frozen_string_literal: true

module Cerberus
  class NotAuthorized < StandardError; end

  # Policy Enforcement Point (PEP).
  # Responsible for resolving a policy and enforcing its decision.
  class Authorizer
    attr_reader :resolver

    def initialize(resolver:)
      @resolver = resolver
    end

    def authorize(action:, subject: nil, resource: nil, env: {})
      policy = resolver.execute(action)

      policy&.evaluate(subject:, resource:, env:) == :permit
    end

    def authorize!(action:, **args)
      raise NotAuthorized, message(action:) unless authorize(action:, **args)

      true
    end

    private

    def message(action:)
      "Not authorized to #{action}"
    end
  end
end
