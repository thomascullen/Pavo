module Peacock
  class StyleguideController < ActionController::Base
    layout 'peacock/application'

    def index
      first_page = Peacock.config.routes.keys.first
      first_section = Peacock.config.routes[first_page].values[0].first
      return redirect_to styleguide_section_path(first_page, first_section)
    end

    def page
      page = params[:page]
      section =  Peacock.config.routes[page].values[0].first
      return redirect_to styleguide_section_path(page, section)
    end

    def show
      @current_page = params[:page]
      @current_section = params[:section]
      @pages = Peacock.config.routes.keys
      @categories = Peacock::Page.categories(@current_page)
      @partial = Peacock::Renderer.content_partial_for(@current_page, @current_section)
      @content = Peacock::Renderer.render(@current_page, @current_section)
    end
  end
end
