module DocxGenerator
  module Word
    class Document < Element
      def initialize(attributes = {}, content = [])
        super("w:document", attributes, content)
      end
    end
    
    class Body < Element
      def initialize(attributes = {}, content = [])
        super("w:body", attributes, content)
      end
    end
    
    class Paragraph < Element
      def initialize(attributes = {}, content = [])
        super("w:p", attributes, content)
      end
    end
    
    class Run < Element
      def initialize(attributes = {}, content = [])
        super("w:r", attributes, content)
      end
    end
    
    class RunProperties < Element
      def initialize(attributes = {}, content = [])
        super("w:rPr", attributes, content)
      end
    end
    
    class Text < Element
      def initialize(attributes = {}, content = [])
        super("w:t", attributes, content)
      end
    end
  end
end
