module Pavo

  class Configuration
    attr_accessor :app_root, :paths, :routes, :markdown, :views_path

    def initialize(options = {})
      @paths = [ "/app/assets/stylesheets" ]
      @views_path = "/app/views/styleguide"
      @routes = {}
    end
    
  end

  class << self

    def configure
      @config ||= Configuration.new
      yield @config
    end

    def config
      @config ||= Configuration.new
    end

  end
end
