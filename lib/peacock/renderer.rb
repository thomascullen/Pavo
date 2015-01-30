module Peacock
  class Renderer
    @reg = /\/\*Styleguide(.*)Styleguide\*\//m
    @extensions = [".css",".css.scss"]

    def self.content_partial_for(page, section)
      # Check if a view file exists
      partial_path = "#{Peacock.config.app_root.to_s}#{Peacock.config.views_path}/#{page.underscore}/_#{section.underscore}.html.erb"
      if File.file?(partial_path)
        return partial_path
      else
        return "/peacock/styleguide/_content.html.erb"
      end
    end

    def self.render(page, section)

      @body = ""

      Peacock.config.paths.each do |path|
        @extensions.each do |extension|
          file_path = "#{Peacock.config.app_root.to_s}#{path}/#{page.underscore}/#{section.underscore}#{extension}"
          if File.file?(file_path)
            styleguide_blocks = File.open(file_path).read().scan(@reg)
            styleguide_blocks.each do |styleguide_block|
              @body += GitHub::Markdown.render_gfm(styleguide_block.first).html_safe
            end
          end
        end
      end

      return @body
    end

  end
end
