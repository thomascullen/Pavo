require 'github/markdown'
require "peacock/engine"
require "peacock/page"
require "peacock/category"
require "peacock/renderer"

module Peacock

  # Add a new styleguide route
  def self.route(page_name, category_name = nil, section_name)
    page = Peacock.config.routes[page_name] ||= {}
    category = page[category_name] ||= [] if category_name
    category = page[page_name] ||= [] unless category_name
    category << section_name
  end

end
