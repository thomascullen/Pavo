require 'pygments'

module Pavo
  # Pavo::Markdown
  class Markdown < Redcarpet::Render::HTML
    def block_code(code, language)
      case language
      when 'styleguide_html'
        styleguide_code_block(code, language)
      when 'styleguide_html_preview'
        "<div class='styleguide-html'>#{styleguide_example(code)}</div>"
      when 'styleguide_colour'
        styleguide_colour(code)
      when 'styleguide_colours'
        stylguide_colours(code)
      when 'fonts'
        stylguide_fonts(code)
      else
        output_code(code, language)
      end
    end

    def header(text, header_level)
      "<h#{header_level} class='styleguide-header-h#{header_level}'>#{text}</h#{header_level}>"
    end

    def paragraph(text)
      "<p class='styleguide-paragraph'>#{text}</p>"
    end

    def codespan(code)
      "<code class='styleguide-code-span'>#{code}</code>"
    end

    def list(contents, list_type)
      "<ul class='styleguide-list styleguide-list-#{list_type}'>
        #{contents}
      </ul>"
    end

    def output_code(code, language)
      language = 'html' if language == 'styleguide_html'
      code = Pygments.highlight(code, lexer: language)
      "<pre class='styleguide-code-block'><code>#{code}</code></pre>"
    end

    def styleguide_example(code)
      "<div class='styleguide-html-preview'>#{code}</div>"
    end

    def styleguide_colour(code)
      colour_regex = /([^:]*):([^:]*):([^:]*)/
      if match = code.match(colour_regex)
        name = match[1].try(:strip)
        colour = match[2].try(:strip)
        variable = match[3].try(:strip)
        "<div class='styleguide-colour'>
          <div class='styleguide-colour-palette' style='background-color:#{colour}'></div>
          <div class='styleguide-colour-info'>
            <h4 class='styleguide-colour-title'>#{name}</h4>
            <span class='styleguide-colour-code'>#{colour}</span>
            <span class='styleguide-colour-variable'>#{variable}</span>
          </div>
        </div>"
      else
        return nil
      end
    end

    def stylguide_colours(code)
      colours = ''
      code.each_line do |line|
        colours << styleguide_colour(line).to_s
      end
      colours
    end

    def stylguide_fonts(code)
      fonts = ''
      code.each_line do |line|
        fonts << styleguide_font(line).to_s
      end
      fonts
    end

    def styleguide_font(code)
      font_regex = /([^:]*):([^:]*)/
      if match = code.match(font_regex)
        font = match[1].try(:strip)
        example_text = match[2].try(:strip)
        "<div class='styleguide-font'>
          <div class='styleguide-font-example' style='font-family:\"#{font}\" !important;'>
          #{example_text}
          </div>
          <h4 class='styleguide-font-name'>#{font}</h4>
        </div>"
      else
        return nil
      end
    end

    def styleguide_code_block(code, language)
      "<div class='styleguide-html'>
#{styleguide_example(code)}
#{output_code(code, language)}
</div>"
    end
  end
end
