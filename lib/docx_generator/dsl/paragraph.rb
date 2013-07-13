module DocxGenerator
  module DSL
    # Represent a paragraph with formatting options
    class Paragraph
      # Create a new paragraph with the formatting options specified.
      # The formatting properties can be passed with a Hash or they could be set by calling the methods on the object (either in the block or not).
      # @param options [Hash] Formatting options.
      # @option options [Boolean] alignment The alignment of the paragraph. See the specification for the complete list.
      def initialize(options = {}, &block)
        @objects = []
        @options = options
        yield self if block
      end

      # Set the alignment of the paragraph. See the specification for more details.
      # @param value [String] The alignment of the paragraph. See the specification for the complete list.
      def alignment(value)
        @options[:alignment] = value
      end

      # Prevent the addition of a space between two text fragments.
      def no_space
        @objects << DocxGenerator::Word::Extensions::NoSpace.new
      end

      # Add a new text fragment to the paragraph.
      # @param text_fragment [String] The text fragment.
      # @param options [Hash] Formatting options for the text fragment. See the full list in DocxGenerator::DSL::Text.
      def text(text_fragment, options = {}, &block)
        text_object = DocxGenerator::DSL::Text.new(text_fragment, options)
        yield text_object if block
        @objects << text_object
      end

      # Generate the XML element objects.
      # @return [DocxGenerator::Word::Paragraph] A Word::Paragraph object representing the paragraph.
      def generate
        text_fragments = generate_text_fragments
        options = generate_paragraph_options
        if options
          Word::Paragraph.new({}, text_fragments.unshift(options))
        else
          Word::Paragraph.new({}, text_fragments)
        end
      end

      # Add other objects to the paragraph.
      # @param objects [Object] Objects (like text fragments).
      # @return [DocxGenerator::DSL::Paragraph] The paragraph object.
      def add(*objects)
        objects.each do |object|
          @objects << object
        end
        self
      end

      private
        def generate_text_fragments
          text_fragments = []
          @objects.each do |object|
            if object.respond_to?(:generate)
              text_fragments << object.generate << Word::Extensions.space
            elsif object.class == DocxGenerator::Word::Extensions::NoSpace
              text_fragments.pop
            end
          end
          text_fragments.pop # In order to remove the last space added
          text_fragments
        end

        def generate_paragraph_options
          unless @options.empty?
            parsed_options = []
            @options.each do |option, value|
              parsed_options << parse_paragraph_option(option, value)
            end
            Word::ParagraphProperties.new(parsed_options)
          end
        end

        def parse_paragraph_option(option, value)
          case option
            when :alignment then Word::Alignment.new(value)
          end
        end
    end
  end
end
