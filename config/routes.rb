Peacock::Engine.routes.draw do
  root to:"styleguide#index"
  get "/:page", to:"styleguide#page", as:"styleguide_page"
  get "/:page/:section", to:"styleguide#show", as: "styleguide_section"
end
