module Pavo
  class Parser
    class << self

      # parse
      # --
      # Interates through the configured paths and build the documentation
      def parse
        Pavo.config.categories = {}
        # Iterate through the configured paths
        Pavo.config.paths.each do |path|
          # if the directory exists
          return unless Dir.exist?(path)
          # for each stylesheet in that directory
          Dir["#{path}/**/*.{css,less,sass,scss}"].each do |filename|
            parse_file(filename)
          end
        end
        # Return parsed sections
        Pavo.config.categories
      end

      # parse_file
      # --
      # Parses a file for styleguide blocks
      def parse_file(file_path)
        File.open(file_path) do |file|
          inside_block = false
          current_category = nil
          current_section = nil

          # for each line
          file.each_line do |line|
            # inside_block to false if line contains a closing styleguide tag
            if Pavo::Parser.end_block(line)
              inside_block = false

            # if inside_block is true
            elsif inside_block
              current_section.content << Pavo::Parser.line(line)

            # if stylguide block is founnd
            elsif Pavo::Parser.start_block(line)
              inside_block = true
              category = Pavo::Parser.category(line)
              section = Pavo::Parser.section(line)

              Pavo.config.categories[category] ||= Pavo::Category.new(title: category)
              current_category = Pavo.config.categories[category]
              current_category.sections_hash[section] ||= Pavo::Section.new(title: section)
              current_section = current_category.sections_hash[section]
            end
          end
        end
        Pavo.config.categories
      end

      # start_block
      # --
      # checks for an opening styleguide tag
      # returns true or false
      def start_block(string)
        !!(string =~ /-~.*~-/)
      end

      # end_block
      # --
      # check for a closing styleguide tag
      # returns true or false
      def end_block(string)
        !!(string =~ /-~-/)
      end

      # category
      # --
      # returns the category form a styleguide tag
      def category(string)
        string.match(/-~\s?(.*)\|(.*)\s?~-/)[1].to_s.try(:strip)
      end

      # section
      # --
      # returns the section form a styleguide tag
      def section(string)
        string.match(/-~\s?(.*)\|(.*)\s?~-/)[2].to_s.try(:strip)
      end

      # line
      # --
      # Removes comments from a line
      def line(string)
        "#{string.to_s.sub(/\s*\/\//, '').try(:lstrip)}\n"
      end
    end

  end
end
