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
            parser = Pavo::FileParser.new(filename)
            parser.parse
          end
        end
        # Return parsed sections
        Pavo.config.categories
      end
    end
  end
end
