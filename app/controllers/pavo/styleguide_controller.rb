module Pavo
  class StyleguideController < ActionController::Base
    layout 'pavo/application'

    def index
      first_page = Pavo.config.routes.keys.first
      first_section = Pavo.config.routes[first_page].values[0].first
      return redirect_to styleguide_section_path(first_page, first_section)
    end

    def page
      page = params[:page]
      section =  Pavo.config.routes[page].values[0].first
      return redirect_to styleguide_section_path(page, section)
    end

    def show
      @current_page = params[:page]
      @current_section = params[:section]
      @pages = Pavo.config.routes.keys
      @categories = Pavo::Page.categories(@current_page)
      @partial = Pavo::Renderer.content_partial_for(@current_page, @current_section)
      @content = Pavo::Renderer.render(@current_page, @current_section)
    end
  end
end
