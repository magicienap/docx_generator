# I should test my code generator!
class WordBase < Thor
  include Thor::Actions

  # Data structure
  # An array of elements
  # Each element can have up to 4 properties
  # - class: The name of the Ruby class (required)
  # - element: The name of the element in the specification.
  #   If not provided, then it is the class name in lowercase
  # - attributes: Wheter it should accept attributes or not (default: true)
  # - content: Wheter it should accept content

  @@elements = [
    { class: "Document" },
    { class: "Body", attributes: false },
    { class: "Paragraph", element: "p" },
    { class: "ParagraphProperties", element: "pPr", attributes: false },
    { class: "Run", element: "r" },
    { class: "RunProperties", element: "rPr", attributes: false },
    { class: "Text", element: "t" },
    { class: "Break", element: "br", content: false }
  ]

  def self.root
    File.expand_path('.')
  end

  desc "code", "Generate the implementation code."
  def code
    # Change that to be a template (ERB?) with helpers
    code =  "# Warning: This file has been automatically generated from generator/word_base.rb.\n" +
            "# It should not be edited by hand. Instead, modify the code generator.\n" +
            "\n" +
            "module DocxGenerator\n" +
            "  module Word\n"

    @@elements.each do |element|
      element = normalize(element)

      code += "    # Represent the `#{element[:element]}` element from Office Open XML specification. This class should not be used directly by the users of the library.\n" +
              "    class #{element[:class]} < Element\n" +
              "      # Create a new `#{element[:element]}` XML element.\n"

      if element[:attributes]
        code += "      # @param attributes [Hash] The attributes of the XML element. Check the specification of the `#{element[:element]}` element for the possible attributes.\n"
      end
      if element[:content]
        code += "      # @param content [Array] An array of the children of the XML element (other XML elements).\n"
      end

      code += "      def initialize("
      code += "attributes = {}" if element[:attributes]
      code += ", " if element[:attributes] && element[:content]
      code += "content = []" if element[:content]
      code += ")\n"

      code += "        super(\"#{element[:element]}\""
      code += element[:attributes] ? ", attributes" : ", {}"
      code += ", content" if element[:content]
      code += ")\n"
      code += "      end\n"

      code += "    end\n\n"
    end

    code += "  end\n"
    code += "end"

    create_file "lib/docx_generator/word/base.rb", code
  end

  desc "spec", "Generate the tests."
  def spec
    code  = "require 'spec_helper'\n\n"

    @@elements.each do |element|
      element = normalize(element)

      code += "describe DocxGenerator::Word::#{element[:class]} do\n" +
              "  it \"should render a #{element[:element]} element\" do\n"

      code += "    DocxGenerator::Word::#{element[:class]}.new.to_s.should eq('<#{element[:element]} />')\n"
      if element[:content]
        code += "    DocxGenerator::Word::#{element[:class]}.new("
        code += "{}, " if element[:attributes]
        code += "[\"Text\"]).to_s.should eq('<#{element[:element]}>Text</#{element[:element]}>')\n"
      end

      code += "  end\n" +
              "end\n\n"
    end

    create_file "spec/docx_generator/word/base_spec.rb", code
  end

  private
    # Add default values to the element
    def normalize(element)
      base = { attributes: true, content: true }
      new_element = base.merge(element)
      new_element[:element] = new_element[:class].downcase if new_element[:element].nil?
      new_element[:element] = "w:" + new_element[:element]
      return new_element
    end
end