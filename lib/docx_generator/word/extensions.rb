module DocxGenerator
  module Word
    module Extensions
      def self.space
        DocxGenerator::Word::Run.new({}, [DocxGenerator::Word::Text.new({ "xml:space" => "preserve" }, [" "])])
      end
    end
  end
end
