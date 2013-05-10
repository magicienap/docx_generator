module DocxGenerator
  class Document
    attr_reader :filename
  
    def initialize(filename)
      @filename = filename
    end
  end
end
