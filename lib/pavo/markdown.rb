module Pavo
  class Markdown < Redcarpet::Render::HTML
    def block_code(code, language)
      case language
      when 'styleguide_html'
        styleguide_code_block(code)
      when 'styleguide_html_example'
        "<div class='styleguide-example-wrapper'>#{styleguide_example(code)}</div>"
      when 'styleguide_colour'
        styleguide_colour(code)
      else
        output_code(code)
      end
    end

    def output_code(code)
      "<pre><code>#{CGI::escapeHTML(code)}</code></pre>"
    end

    def styleguide_example(code)
      "<div class='styleguide-example'>#{code}</div>"
    end

    def styleguide_colour(code)
      colour_regex = /([^:]*):([^:]*):([^:]*)/
      if match = code.match(colour_regex)
        name = match[1].try(:strip)
        colour = match[2].try(:strip)
        variable = match[3].try(:strip)
        "<div class='styleguide-colour'>
          <div class='styleguide-colour-palette' style='background-color:#{colour}'></div>
          <h4>#{name}</h4>
          <span class='styleguide-colour-code'>#{colour}</span>
          <span class='styleguide-colour-variable'>#{variable}</span>
        </div>"
      else
        return nil
      end
    end

    def styleguide_code_block(code)
      "<div class='styleguide-example-wrapper'>
#{styleguide_example(code)}
#{output_code(code)}
</div>"
    end
  end
end
