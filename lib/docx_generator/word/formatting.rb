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
  end
end
