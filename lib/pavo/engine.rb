require "pavo/configuration"

module Pavo

  attr_accessor :app_root

  class Engine < Rails::Engine

    isolate_namespace Pavo

    initializer "Pavo.load_app_root" do |app|
      Pavo.config.app_root = app.root
    end

  end
end
