require 'spec_helper'

describe DocxGenerator::DSL::Document do
  after do
    File.delete("word.docx") if File.exists?("word.docx")
  end
  
  it "should pass itself to a block" do
    inner_doc = nil
    document = DocxGenerator::DSL::Document.new("word") do |doc|
      inner_doc = doc
    end
    inner_doc.should be(document)
  end

  describe "#save" do
    after do
      File.delete("word.docx")
    end
  
    it "should save the document" do
      document = DocxGenerator::DSL::Document.new("word") { |doc| doc.save }
      File.exists?("word.docx").should be_true
    end
  end

  describe "paragraph" do
    it "should pass a DocxGenerator::DSL::Paragraph object to a block" do
      document = DocxGenerator::DSL::Document.new("word") do |doc|
        par_class = nil
        doc.paragraph { |par| par_class = par.class }
        par_class.should be(DocxGenerator::DSL::Paragraph)
      end
    end

    xit "should add a paragraph to the document" do
      document = DocxGenerator::DSL::Document.new("word") do |doc|
        doc.paragraph { |par| }
        doc.save
      end
      open_file("word/document.xml").should include("<w:p>")
    end
  end
end
