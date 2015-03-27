module Pavo
  class Category
    attr_accessor :title, :sections_hash

    def initialize(attributes = {})
      @sections_hash = {}
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def sections
      sections_hash.values
    end

    class << self
      def all
        Pavo.config.categories.values
      end
    end
  end
end
