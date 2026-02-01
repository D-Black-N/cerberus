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
    def self.cast(value, type)
      case type
      when "string", "nil" then value
      when "integer"       then Integer(value)
      when "float"         then Float(value)
      when "boolean"       then value == "true"
      when "time"          then Time.parse(value)
      when "date"          then Date.parse(value)
      when "datetime"      then DateTime.parse(value)
      when "json"          then JSON.parse(value)
      end
    end
  end
end
