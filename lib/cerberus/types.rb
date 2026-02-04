# frozen_string_literal: true

module Cerberus
  # Provides basic value type casting utilities.
  #
  # This module is responsible for converting raw operand values
  # into their declared types before condition evaluation.
  #
  # Type casting is based on a simple string-based type identifier
  # and is intentionally kept minimal for core usage.
  #
  # Supported types include:
  # - string
  # - nil
  # - integer
  # - float
  # - boolean
  # - time
  # - date
  # - datetime
  # - json
  #
  module Types
    MAPPER = {
      "string" => ->(value) { value },
      "integer" => ->(value) { Integer(value) },
      "float" => ->(value) { Float(value) },
      "boolean" => ->(value) { value == "true" },
      "time" => ->(value) { Time.parse(value) },
      "date" => ->(value) { Date.parse(value) },
      "datetime" => ->(value) { DateTime.parse(value) },
      "json" => ->(value) { JSON.parse(value) },
      "nil" => ->(_) { nil }
    }.freeze

    def self.cast(value, type)
      MAPPER.fetch(type).call(value)
    end
  end
end
