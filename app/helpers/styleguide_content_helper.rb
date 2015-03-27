# Styleguide block
module StyleguideContentHelper
  def styleguide_content(content)
    Pavo.config.renderer.render(content).html_safe
  end
end
