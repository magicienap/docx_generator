module DocxGenerator
  module DSL
    class Document
      def initialize(filename)
        @document = DocxGenerator::Document.new(filename)
        @objects = []
        yield self
      end

      def save
        @objects.each do |object|
          object.generate(@document)
        end
        @document.save
      end

      def paragraph
        par = DocxGenerator::DSL::Paragraph.new
        yield par
        @objects.push(par)
      end
    end
  end
end
