# Pavo
module Pavo
  # Pavo::Configuration
  class Configuration
    attr_accessor :paths, :renderer, :categories, :parse_on_each_request

    def initialize
      @categories = {}
      @paths = []
      @parse_on_each_request = false
      renderer = Pavo::Markdown.new(prettify: 'testing', hard_wrap: false)
      options = {
        tables: true, autolink: true, no_intra_emphasis: true,
        fenced_code_blocks: true, disable_indented_code_blocks: true
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
