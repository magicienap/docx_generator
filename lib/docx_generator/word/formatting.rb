module DocxGenerator
  module Word
    class Bold < Element
      def initialize(present = nil)
        arguments = (present == nil ? {} : { "w:val" => present })
        super("w:b", arguments)
      end
    end
    
    class Italics < Element
      def initialize(present = nil)
        arguments = (present == nil ? {} : { "w:val" => present })
        super("w:i", arguments)
      end
    end

    class Underline < Element
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

    class Size < Element
      # size : The font size in points
      def initialize(size)
        super("w:sz", { "w:val" => "#{size}pt" })
      end
    end

    class Alignment < Element
      def initialize(value)
        super("w:jc", { "w:val" => value })
      end
    end
  end
end
