module DocxGenerator

  # Represent an XML element. This class should not be used directly by the users of the library.
  class Element

    # Create a new XML element.
    # @param name [String] The name of the XML element.
    # @param attributes [Hash] The attributes of the XML element.
    # @param content [Array] An array of the children of the XML element (other XML elements).
    def initialize(name, attributes = {}, content = [])
      @name = name
      @attributes = attributes
      @content = content
    end
    
    # Add an XML element in the content of this XML element.
    # @param element[DocxGenerator::Element] The XML element to add.
    def add(element)
      @content << element
    end
    
    # Generate the XML for the element.
    # @return [String] The XML produced for the element.
    def generate
      output = ""
      if @content.length != 0
        output += "<#{@name}#{generate_attributes}>"
        @content.each do |element|
          if element.respond_to?(:generate)
            output += element.generate
          else
            output += element.to_s
          end
        end
        output += "</#{@name}>"
      else
        output += "<#{@name}#{generate_attributes} />"
      end
      output
    end
    alias :to_s :generate
    
    private
      def generate_attributes
        output = ""
        @attributes.each do |name, value|
          output += " #{name}=\"#{value}\""
        end
        output
      end
  end
end
