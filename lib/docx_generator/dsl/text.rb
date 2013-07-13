module DocxGenerator
  module DSL
    class Text
      def initialize(text_fragment, options = {}, &block)
        @text_fragment = text_fragment
        @options = options
        yield self if block
      end

      def bold(value)
        @options[:bold] = value
      end

      def italics(value)
        @options[:italics] = value
      end

      def underline(value)
        @options[:underline] = value
      end

      def size(value)
        @options[:size] = value
      end

      def superscript(value)
        @options[:superscript] = value
      end

      def subscript(value)
        @options[:subscript] = value
      end

      def generate
        options = generate_text_options
        text = Word::Text.new({}, [@text_fragment])
        if options
          Word::Run.new({}, [options, text])
        else
          Word::Run.new({}, [text])
        end
      end

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
            Word::RunProperties.new({}, parsed_options)
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
