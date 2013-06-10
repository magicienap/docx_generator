module DocxGenerator
  module DSL
    class Paragraph
      def initialize(&block)
        @objects = []
        yield self if block
      end

      def generate(document)
        text_fragments = []
        @objects.each do |object|
          text_fragments.push object.generate(document)
        end
        document.add_paragraph(*text_fragments)
      end

      def text(text_fragment, &block)
        text_object = DocxGenerator::DSL::Text.new(text_fragment)
        yield text_object if block
        @objects.push(text_object)
      end
    end
  end
end
