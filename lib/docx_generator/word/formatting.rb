module DocxGenerator
  module Word
    # Represent the `w:b` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Bold < Element
      # Create a new `w:b` element.
      # @param present [Boolean] If bold should be applied to the text.
      def initialize(present = nil)
        arguments = (present == nil ? {} : { "w:val" => present })
        super("w:b", arguments)
      end
    end
    
    # Represent the `w:i` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Italics < Element
      # Create a new `w:i` element.
      # @param present [Boolean] If italics should be applied to the text.
      def initialize(present = nil)
        arguments = (present == nil ? {} : { "w:val" => present })
        super("w:i", arguments)
      end
    end

    # Represent the `w:u` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Underline < Element
      # Create a new `w:u` element.
      # @param arguments [Hash] Arguments for the `w:u` element. See the full list in the specification. You can use `style` instead of `w:val` if you want. The list of all underline patterns can be found in the specification.
      def initialize(arguments = { "w:val" => "single" })
        final_arguments = {}
        arguments.each do |option, value|
          case option
            when :style then final_arguments["w:val"] = value
            else final_arguments[option] = value
          end
        end
        super("w:u", final_arguments)
      end
    end

    # Represent the `w:sz` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Size < Element
      # Create a new `w:sz` element.
      # @param size [Number] The size of the text (in points)
      def initialize(size)
        super("w:sz", { "w:val" => size*2 })
      end
    end

    # Represent the `w:jc` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class Alignment < Element
      # Create a new `w:jc` element.
      # @param value [String] The type of alignment. The list of all types of alignment can be found in the specification.
      def initialize(value)
        super("w:jc", { "w:val" => value })
      end
    end

    # Represent the `w:vertAlign` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class VerticalAlign < Element
      # Create a new `w:vertAlign` element.
      # @param value [String] The type of alignment. It should be `baseline`, `subscript` or `superscript`.
      def initialize(value)
        super("w:vertAlign", { "w:val" => value })
      end
    end

    # Represent the `w:caps` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class CapitalLetters < Element
      # Create a new `w:caps` element.
      # @param present [Boolean] If the text should be displayed in capital letters.
      def initialize(present = nil)
        arguments = (present == nil ? {} : { "w:val" => present })
        super("w:caps", arguments)
      end
    end

    # Represent the `w:smallCaps` element from Office Open XML specification. This class should not be used directly by the users of the library.
    class SmallCapitalLetters < Element
      # Create a new `w:smallCaps` element.
      # @param present [Boolean] If the text should be displayed in small capital letters.
      def initialize(present = nil)
        arguments = (present == nil ? {} : { "w:val" => present })
        super("w:smallCaps", arguments)
      end
    end
  end
end
