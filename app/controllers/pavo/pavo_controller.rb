module Pavo
  class PavoController < ActionController::Base
    layout 'pavo/application'

    before_action :load_styleguide

    # Renders the styleguide
    def styleguide
      @sections = Pavo.config.sections
    end

    private

    def load_styleguide
      Pavo::Parser.parse
    end

  end
end
