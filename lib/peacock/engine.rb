require "peacock/configuration"

module Peacock

  attr_accessor :app_root

  class Engine < Rails::Engine

    isolate_namespace Peacock

    initializer "peacock.load_app_root" do |app|
      Peacock.config.app_root = app.root
    end

  end
end
