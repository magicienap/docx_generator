module DocxGenerator
  module DSL
    class Paragraph
      def initialize(options = {}, &block)
        @objects = []
        @options = options
        yield self if block
      end

      def alignment(value)
        @options[:alignment] = value
      end

      def no_space
        @objects << DocxGenerator::Word::Extensions::NoSpace.new
      end

      def text(text_fragment, options = {}, &block)
        text_object = DocxGenerator::DSL::Text.new(text_fragment, options)
        yield text_object if block
        @objects << text_object
      end

      def generate
        text_fragments = generate_text_fragments
        options = generate_paragraph_options
        if options
          Word::Paragraph.new({}, text_fragments.unshift(options))
        else
          Word::Paragraph.new({}, text_fragments)
        end
      end

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
