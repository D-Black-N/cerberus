# frozen_string_literal: true

module Cerberus
  class Plugins
    def self.load(config, name, **opts)
      require "cerberus/plugins/#{name}"

      config.plugins << name

      const_get(name.to_s.split('_').map(&:capitalize).join)
        .apply(config, **opts)
    end
  end
end
