# frozen_string_literal: true

module Cerberus
  class Configuration
    attr_accessor :resolver

    def plugins
      @plugins ||= []
    end
  end
end
