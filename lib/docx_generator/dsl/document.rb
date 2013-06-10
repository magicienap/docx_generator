module DocxGenerator
  module DSL
    class Document
      def initialize(filename)
        @document = DocxGenerator::Document.new(filename)
        yield self
      end

      def save
        @document.save
      end

      def paragraph
        yield DocxGenerator::DSL::Paragraph.new
      end
    end
  end
end
