# frozen_string_literal: true

module Cerberus
  class Configuration
    attr_accessor :authorizer

    def plugins
      @plugins ||= []
    end
  end
end
