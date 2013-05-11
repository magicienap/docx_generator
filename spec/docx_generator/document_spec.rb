require 'spec_helper'

describe DocxGenerator::Document do
  it "should create a new docx document with the filename specified" do
    document = DocxGenerator::Document.new("word")
    document.filename.should eq("word")
  end
  
  describe "#save" do
    let(:document) { DocxGenerator::Document.new("word") }
  
    after do
      File.delete("word.docx")
    end
  
    it "should save the document" do
      document.save
      File.exists?("word.docx").should be_true
    end
    
    describe "required documents" do
      before { DocxGenerator::Document.new("word").save }
    
      it "should generate a [Content_Types].xml file" do
        Zip::Archive.open("word.docx") do |docx|
          expect { docx.fopen("[Content_Types].xml") }.to_not raise_error
        end
      end
      
      it "should generate a _rels/.rels file" do
        Zip::Archive.open("word.docx") do |docx|
          expect { docx.fopen("_rels/.rels") }.to_not raise_error
        end
      end
      
      it "should generate a word/document.xml" do
        Zip::Archive.open("word.docx") do |docx|
          expect { docx.fopen("word/document.xml") }.to_not raise_error
        end
      end
    end
  end
  
  describe "#add_paragraph" do
    let(:document) { DocxGenerator::Document.new("word") }
    
    before do
      document.add_paragraph("The first characters", "and the last ones.").save
    end

    after do
      File.delete("word.docx")
    end
  
    it "adds a paragraph with the fragments supplied separated by a space" do # Space : an option
      open_file("word/document.xml").should include("<w:p><w:r><w:t>The first characters</w:t></w:r><w:r><w:t xml:space=\"preserve\"> </w:t></w:r><w:r><w:t>and the last ones.</w:t></w:r></w:p>")
    end
    
    it "returns the current document" do
      document.add_paragraph(["The first characters", "and the last ones."]).should be(document)
    end
  end
end
