require 'rails/generators'

module Pavo
  class InstallGenerator < Rails::Generators::Base
    desc "Installs pavo"

    def create_setup
      route 'mount Pavo::Engine, at:"/styleguide"'
      initializer 'pavo.rb' do
"Pavo.configure do |config|
  config.paths << Rails.root.join('app/assets/stylesheets').to_s
end"
      end
    end
  end
end
