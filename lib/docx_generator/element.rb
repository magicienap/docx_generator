module DocxGenerator
  class Element
    def initialize(name, attributes = {}, content = [])
      @name = name
      @attributes = attributes
      @content = content
    end
    
    def add(element)
      @content << element
    end
    
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
