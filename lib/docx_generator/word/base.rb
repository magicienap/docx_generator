module DocxGenerator
  module Word
    # Represent the `w:document` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Document < Element
      # Create a new `w:document` XML element.
      # @param attributes [Hash] The attributes of the XML element. Check the specification of the `w:document` element for the possible attributes.
      # @param content [Array] An array of the children of the XML element (other XML elements).
      def initialize(attributes = {}, content = [])
        super("w:document", attributes, content)
      end
    end

    # Represent the `w:body` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Body < Element
      # Create a new `w:body` XML element.
      # @param content [Array] An array of the children of the XML element (other XML elements).
      def initialize(content = [])
        super("w:body", {}, content)
      end
    end

    # Represent the `w:p` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Paragraph < Element
      # Create a new `w:p` XML element.
      # @param attributes [Hash] The attributes of the XML element. Check the specification of the `w:p` element for the possible attributes.
      # @param content [Array] An array of the children of the XML element (other XML elements).
      def initialize(attributes = {}, content = [])
        super("w:p", attributes, content)
      end
    end

    # Represent the `w:pPr` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class ParagraphProperties < Element
      # Create a new `w:pPr` XML element.
      # @param content [Array] An array of the children of the XML element (other XML elements).
      def initialize(content = [])
        super("w:pPr", {}, content)
      end
    end

    # Represent the `w:r` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Run < Element
      # Create a new `w:r` XML element.
      # @param attributes [Hash] The attributes of the XML element. Check the specification of the `w:r` element for the possible attributes.
      # @param content [Array] An array of the children of the XML element (other XML elements).
      def initialize(attributes = {}, content = [])
        super("w:r", attributes, content)
      end
    end

    # Represent the `w:rPr` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class RunProperties < Element
      # Create a new `w:rPr` XML element.
      # @param content [Array] An array of the children of the XML element (other XML elements).
      def initialize(content = [])
        super("w:rPr", {}, content)
      end
    end

    # Represent the `w:t` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Text < Element
      # Create a new `w:t` XML element.
      # @param attributes [Hash] The attributes of the XML element. Check the specification of the `w:t` element for the possible attributes.
      # @param content [Array] An array of the children of the XML element (other XML elements).
      def initialize(attributes = {}, content = [])
        super("w:t", attributes, content)
      end
    end

    # Represent the `w:br` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Break < Element
      # Create a new `w:br` XML element.
      # @param attributes [Hash] The attributes of the XML element. Check the specification of the `w:br` element for the possible attributes.
      def initialize(attributes = {})
        super("w:br", attributes)
      end
    end
  end
end
