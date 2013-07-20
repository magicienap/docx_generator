module DocxGenerator
  module Word

    # Extensions to create some common elements easily.
    module Extensions
      def self.space
        DocxGenerator::Word::Run.new({}, [DocxGenerator::Word::Text.new({ "xml:space" => "preserve" }, [" "])])
      end

      def self.newline
      	DocxGenerator::Word::Run.new({}, [DocxGenerator::Word::Break.new])
      end

      class Newline
        def generate
          DocxGenerator::Word::Run.new({}, [DocxGenerator::Word::Break.new])
        end
      end

      class Tab
        def generate
          DocxGenerator::Word::Run.new({}, [DocxGenerator::Word::Tab.new])
        end
      end

      class NoSpace
      end
    end
  end
end
