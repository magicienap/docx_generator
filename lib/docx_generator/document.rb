module DocxGenerator
  class Document
    attr_reader :filename
  
    def initialize(filename)
      @filename = filename
      @content = []
    end
    
    def save
      content_types = generate_content_types
      rels = generate_rels
      document = generate_document
      
      Zip::Archive.open(@filename + ".docx", Zip::CREATE | Zip::TRUNC) do |docx|
        docx.add_dir('_rels')
        docx.add_dir('word')
        docx.add_buffer('[Content_Types].xml', content_types)
        docx.add_buffer('_rels/.rels', rels)
        docx.add_buffer('word/document.xml', document)
      end
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
        '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' +
        Word::Document.new({ "xmlns:w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main" },
          [ Word::Body.new({}, @content) ]).to_s
      end
  end
end
