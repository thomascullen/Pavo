module Pavo
  class FileParser
    attr_accessor :inside_code_block, :file_path

    def initialize(file_path)
      @inside_code_block = false
      @file_path = file_path
    end

    # begin parsing the file
    def parse
      File.open(file_path) do |file|
        inside_block = false
        current_category = nil
        current_section = nil

        # for each line
        file.each_line do |line|
          # inside_block to false if line contains a closing styleguide tag
          if end_block(line)
            inside_block = false

          # if inside_block is true
          elsif inside_block
            current_section.content << parse_line(line) if should_parse?(line)

          # if stylguide block is founnd
          elsif start_block(line)
            inside_block = true
            category = category(line)
            section = section(line)

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
    def parse_line(string)
      code_block(string)
      string = string.to_s.sub(/\s*\/\//, '')
      string = string.try(:lstrip) unless inside_code_block
      # check if the line is a header, code block, list, etc.
      return "\n#{string}\n" if markdown_tag?(string)
      string.to_s
    end

    # sets wether currently parsing a code block
    def code_block(string)
      return unless string =~ /\s*~~~|\s*```/
      if self.inside_code_block
        self.inside_code_block = false
      else
        self.inside_code_block = true
      end
    end

    # returns true if the stirng has markdown tags
    # This is to check if a linebreak needs to be added to the string
    # header, codeblock, list. etc.
    def markdown_tag?(string)
      !!(string =~ /^\s?[#-]|^\s?\~\~\~|^\s?\`\`\`/)
    end

    # returns if a string is commented or not
    def is_commented?(string)
      !!(string =~ /\s*\/\//)
    end

    # returns if a line should be excluded from parsing using the ::
    def excluded_line?(string)
      !!(string =~ /\s*\/\/\s*\-\:\s*/)
    end

    # returns if a line should be parsed
    def should_parse?(string)
      return true if is_commented?(string) && !excluded_line?(string)
      return false
    end

  end
end
