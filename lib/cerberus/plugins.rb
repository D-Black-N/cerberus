# frozen_string_literal: true

class Plugins
  def self.load(cerberus, name, **opts)
    require "cerberus/plugins/#{name}"

    const_get(name.to_s.split('_').map(&:capitalize).join)
      .apply(cerberus.configuration, **opts)
  end
end
