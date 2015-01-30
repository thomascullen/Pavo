require 'github/markdown'
require "pavo/engine"
require "pavo/page"
require "pavo/category"
require "pavo/renderer"

module Pavo

  # Add a new styleguide route
  def self.route(page_name, category_name = nil, section_name)
    page = Pavo.config.routes[page_name] ||= {}
    category = page[category_name] ||= [] if category_name
    category = page[page_name] ||= [] unless category_name
    category << section_name
  end

end
