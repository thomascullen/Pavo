$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pavo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pavo"
  s.version     = Pavo.version
  s.authors     = ["Thomas Cullen"]
  s.email       = ["thomascullen92@gmail.com"]
  s.homepage    = "https://github.com/Thomascullen92/Pavo"
  s.summary     = "Living Style Guides"
  s.description = "Living Style Guides"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'sass-rails'
  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "redcarpet", "~>3.2.2"

  s.add_development_dependency "sqlite3"
end
