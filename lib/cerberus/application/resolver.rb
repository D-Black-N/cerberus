# frozen_string_literal: true

module Cerberus
  module Application
    class Resolver
      def initialize(repository:, mapper:)
        @repository = repository
        @mapper     = mapper
      end

      def resolve(action)
        record = repository.find(action)
        return unless record

        mapper.call(record)
      end

      private

      attr_reader :repository, :mapper
    end
  end
end
