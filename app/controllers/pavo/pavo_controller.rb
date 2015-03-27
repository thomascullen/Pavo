module Pavo
  class PavoController < ActionController::Base
    layout 'pavo/application'

    before_action :load_styleguide

    # Renders the styleguide
    def styleguide
      @categories = Pavo::Category.all
    end

    private

    def load_styleguide
      Pavo::Parser.parse
    end

  end
end
