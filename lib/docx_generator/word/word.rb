module DocxGenerator
  module Word
    class Document < DocxGenerator::Element
      def initialize(attributes = {}, content = [])
        super("w:document", attributes, content)
      end
    end
    
    class Body < Element
      def initialize(attributes = {}, content = [])
        super("w:body", attributes, content)
      end
    end
  end
end
