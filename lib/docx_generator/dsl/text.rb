module DocxGenerator
  module DSL
    class Text
      def initialize(text_fragment, &block)
        @text_fragment = text_fragment
        yield self if block
      end

      def generate(document)
        document.text(@text_fragment)
      end
    end
  end
end
