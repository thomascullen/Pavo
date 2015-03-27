module Pavo
  class Configuration
    attr_accessor :paths, :sections, :renderer

    def initialize
      @sections = {}
      @paths = []
      renderer = Pavo::Markdown.new(prettify: 'testing')

      options = {
        tables: true,
        autolink: true,
        fenced_code_blocks: true,
        disable_indented_code_blocks: true
      }

      @renderer = Redcarpet::Markdown.new(renderer, options)
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
