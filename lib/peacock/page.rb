module Peacock
  class Page

    def self.categories(page)
      categories = []
      Peacock.config.routes[page].keys.each do |category|
        sections = Peacock.config.routes[page][category]
        category_class = Peacock::Category.new
        category_class.title = category
        category_class.sections = sections
        categories << category_class
      end
      return categories
    end

  end
end
