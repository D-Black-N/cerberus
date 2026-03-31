# frozen_string_literal: true

module Cerberus
  module Types
    MAPPER = {
      'string'   => ->(value) { value },
      'integer'  => ->(value) { Integer(value) },
      'float'    => ->(value) { Float(value) },
      'boolean'  => ->(value) { value == 'true' },
      'time'     => ->(value) { Time.parse(value) },
      'date'     => ->(value) { Date.parse(value) },
      'datetime' => ->(value) { DateTime.parse(value) },
      'json'     => ->(value) { JSON.parse(value) },
      'nil'      => ->(_) {}
    }.freeze

    def self.cast(value, type)
      MAPPER.fetch(type).call(value)
    end
  end
end
