module Pavo
  class Parser
    class << self

      # parse
      # --
      # Interates through the configured paths and build the documentation
      def parse
        Pavo.config.sections = {}
        # Iterate through the configured paths
        Pavo.config.paths.each do |path|
          # if the directory exists
          return unless Dir.exists?(path)
          # for each stylesheet in that directory
          Dir["#{path}/**/*.{css,less,sass,scss}"].each do |filename|
            parse_file(filename)
          end
        end
        # Return parsed sections
        Pavo.config.sections
      end

      # parse_file
      # --
      # Parses a file for styleguide blocks
      def parse_file(file_path)
        File.open(file_path) do |file|
          inside_block = false
          category = nil
          section = nil

          file.each_line do |line|
            # Set inside block to true if the line contains an opening
            # styleguide tag
            if Pavo::Parser.end_block(line)
              inside_block = false

            elsif inside_block
              Pavo.config.sections[category][section] << Pavo::Parser.line(line)

            elsif Pavo::Parser.start_block(line)
              inside_block = true
              category = Pavo::Parser.category(line)
              section = Pavo::Parser.section(line)

              Pavo.config.sections[category] = {} unless Pavo.config.sections[category]
              Pavo.config.sections[category][section] = '' unless Pavo.config.sections[category][section]
            end
          end
        end
        Pavo.config.sections
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
