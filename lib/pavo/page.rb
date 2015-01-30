module Pavo
  class Page

    def self.categories(page)
      categories = []
      Pavo.config.routes[page].keys.each do |category|
        sections = Pavo.config.routes[page][category]
        category_class = Pavo::Category.new
        category_class.title = category
        category_class.sections = sections
        categories << category_class
      end
      return categories
    end

  end
end
