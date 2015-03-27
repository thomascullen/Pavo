module Pavo
  class Section
    attr_accessor :title, :content

    def initialize(attributes = {})
      @content = ''
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def href
      "##{id}"
    end

    def id
      title.gsub(/ /, '').downcase.underscore
    end
  end
end
