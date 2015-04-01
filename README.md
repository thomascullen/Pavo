#Pavo
####Build a living styleguide inside Ruby on Rails applications
Pavo is a rails engine that makes it really easy to add a living styleguide to your rails application by parsing commented markdown inside your CSS files.

### Setup
Add pavo to your gemfile
~~~
gem 'pavo'
~~~
Run the installer fom the root directory of your rails app
~~~
rails g pavo:install
~~~
This will mount the stylguide inside your `routes.rb` under the path `/styleguide`. It will also create an inntializer `pavo.rb` to configure the styleguide.

### Configuration
#####Paths
You can specify the folders you want pavo to search for styleguide documentation by adding a path to the `paths` array. The default rails path for CSS files is added by default.
~~~
Pavo.configure do |config|
  config.paths << Rails.root.join('app/assets/stylesheets').to_s
end
~~~
#####Parse On Each Request
By default the CSS files are only parsed for documentation the first time a request is made to `/styleguide`. Once the files have been parsed the documentation will be loaded from memory. You may want to disable this in development so that the styleguide will update everytime you refersh. You can addd the following to your `development.rb` file to do so.
~~~
Pavo.configure do |config|
  config.parse_on_each_request = true
end
~~~

### How to styleguide?!?
The sytleguide is broken down into categories and sections. Each section belongs to a category. Pavo knows where to parse documentation from by using styleguide comment blocks.
######Creating a styleguide block
To open a styleguide block you use the opening styleguide comment block.
~~~
// -~ Category Name | Section Name ~-
~~~
To close a styleguide block you use the closing styleguide comment block.
~~~
// -~-
~~~
Pavo will parse any comments in between these blocks for markdown and add it to the styleguide.
e.g
Lets say we have a `button.scss` file and we want to add dome styleguide documentation in a 'Buttons' section in a `Forms` category. Inside your `buttons.scss` file you would add.
~~~
// -~ Forms | Buttons ~-
// #Header
// This markdown will be parsed
.button{
  ...
}
// -~-
~~~

### But wait there's more!
Pavo uses a custom version of markdown to enable you to add special styleguide elements.

####Styleguide HTML Code Blocks
Styleguide HTML code blocks will render a preview of the code inside the code block and also output the code in `pre` tags below the preview.
~~~
// ~~~styleguide_html
// <a href='#' class='button'>Click Me</a>
// ~~~
~~~

####Colour Palette
You can render a colour pallete block by using the `styleguide_colour` code block.
~~~
// ~~~styleguide_colour
// Colour Name : #HEX : $variable_name
// ~~~
~~~
You can render multiple colour palette blocks using the `styleguide_colours` code block.
~~~
// ~~~styleguide_colours
// Colour Name : #HEX : $variable_name
// Colour Name : #HEX : $variable_name
// Colour Name : #HEX : $variable_name
// ~~~
~~~

###Font Blocks
You can render a font block using the `fonts` code block.
~~~
// ~~~fonts
// Font Name : Text Preview
// Font Name : Text Preview
// ~~~
~~~

## Customizing the styleguide
More documentation to come
