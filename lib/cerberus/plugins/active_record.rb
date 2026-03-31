# frozen_string_literal: true

module Plugins
  class ActiveRecord
    def self.load(_config, **)
      require 'active_record'
    end
  end
end
