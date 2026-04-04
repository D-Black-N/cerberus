# frozen_string_literal: true

class Configuration
  attr_reader :resolver

  def plugins
    @plugins ||= []
  end
end
