module Pavo
  # PavoController
  class PavoController < ActionController::Base
    layout 'pavo/application'

    before_action :load_styleguide

    # Renders the styleguide
    def styleguide
      @categories = Pavo::Category.all
    end

    private

    # Parse the styleguide
    def load_styleguide
      return if Pavo.config.parse_on_each_request == false && Pavo.config.categories.any?
      Pavo::Parser.parse
    end
  end
end
