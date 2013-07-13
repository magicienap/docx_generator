module DocxGenerator
  module DSL
    # Represent a text fragment with formatting options
    class Text
      # Create a new text fragment with the text specified.
      # The formatting properties can be passed with a Hash or they could be set by calling the methods on the object (either in the block or not).
      # @param text_fragment [String] The text fragment.
      # @param options [Hash] Formatting options.
      # @option options [Boolean] bold If the text should be in bold.
      # @option options [Boolean] italics If the text should be in italics.
      # @option options [Hash] underline The style of the underline and other options. See the specification for more details.
      # @option options [Integer] size The size of the text (in points).
      # @option options [Boolean] superscript If the text should be in superscript.
      # @option options [Boolean] subscript If the text should be in subscript.
      def initialize(text_fragment, options = {}, &block)
        @text_fragment = text_fragment
        @options = options
        yield self if block
      end

      # Set whether the text should be in bold or not.
      # @param value [Boolean] Whether the text should be in bold or not.
      def bold(value)
        @options[:bold] = value
      end

      # Set whether the text should be in italics or not.
      # @param value [Boolean] Whether the text should be in italics or not.
      def italics(value)
        @options[:italics] = value
      end

      # Set the style of the underline and other options. See the specification for more details.
      # @param value [Hash] The style of the underline and other options. See the specification for more details.
      def underline(value)
        @options[:underline] = value
      end

      # Set the size of the text (in points).
      # @param value [Integer] The size of the text (in points).
      def size(value)
        @options[:size] = value
      end

      # Set whether the text should be in superscript.
      # @param value [Boolean] Whether the text should be in superscript.
      def superscript(value)
        @options[:superscript] = value
      end

      # Set whether the text should be in subscript.
      # @param value [Boolean] Whether the text should be in subscript.
      def subscript(value)
        @options[:subscript] = value
      end

      # Generate the XML element objects.
      # @return [DocxGenerator::Word::Run] A Word::Run object representing the text fragment.
      def generate
        options = generate_text_options
        text = Word::Text.new({}, [@text_fragment])
        if options
          Word::Run.new({}, [options, text])
        else
          Word::Run.new({}, [text])
        end
      end

      # Generate the XML representation of the text fragment
      def to_s
        generate.to_s
      end

      private
        def generate_text_options
          unless @options.empty?
            parsed_options = []
            @options.each do |option, value|
              parsed_options << parse_text_option(option, value)
            end
            Word::RunProperties.new(parsed_options)
          end
        end

        def parse_text_option(option, value)
          case option
            when :bold then Word::Bold.new(value)
            when :italics then Word::Italics.new(value)
            when :underline then Word::Underline.new(value)
            when :size then Word::Size.new(value)
            when :superscript then Word::VerticalAlign.new("superscript")
            when :subscript then Word::VerticalAlign.new("subscript")
          end
        end
    end
  end
end
