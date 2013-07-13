module DocxGenerator
  module DSL
    class Document
      attr_reader :filename
    
      def initialize(filename, &block)
        @filename = filename + ".docx"
        @objects = [] # It contains all the DSL elements
        yield self if block
      end
      
      # Could be better
      def save
        content_types = generate_content_types
        rels = generate_rels
        document = generate_document
        
        File.delete(@filename) if File.exists?(@filename)
        Zip::ZipFile.open(@filename, Zip::ZipFile::CREATE) do |docx|
          docx.mkdir('_rels')
          docx.mkdir('word')
          docx.get_output_stream('[Content_Types].xml') { |f| f.puts content_types }
          docx.get_output_stream('_rels/.rels') { |f| f.puts rels }
          docx.get_output_stream('word/document.xml') { |f| f.puts document }
        end
      end

      def paragraph(options = {}, &block)
        par = DocxGenerator::DSL::Paragraph.new(options)
        yield par if block
        @objects << par
      end

      def add(*objects)
        objects.each do |object|
          @objects << object
        end
        self
      end
      
      private
      
        def generate_content_types
          <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
</Types>
EOF
        end
        
        def generate_rels
          <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>
EOF
        end
        
        def generate_document
          content = []
          @objects.each do |object|
            content << object.generate
          end

          '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' +
          Word::Document.new({ "xmlns:w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main" },
            [ Word::Body.new({}, content) ]).to_s
        end
    end
  end
end
