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
end
