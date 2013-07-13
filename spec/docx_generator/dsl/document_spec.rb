require 'spec_helper'

describe DocxGenerator::DSL::Document do
  after do
    File.delete("word.docx") if File.exists?("word.docx")
  end

  it "should create a new docx document with the filename specified" do
    document = DocxGenerator::DSL::Document.new("word")
    document.filename.should eq("word.docx")
  end
  
  it "should pass itself to a block if a block is given" do
    inner_doc = nil
    document = DocxGenerator::DSL::Document.new("word") do |doc|
      inner_doc = doc
    end
    inner_doc.should be(document)
  end

  describe "#save" do  
    let(:document) { DocxGenerator::DSL::Document.new("word") }

    it "should save the document" do
      document.save
      File.exists?("word.docx").should be_true
    end
    
    describe "required documents" do
      before { DocxGenerator::DSL::Document.new("word").save }
    
      it "should generate a [Content_Types].xml file" do
        Zip::ZipFile.open("word.docx") do |docx|
          expect { docx.read("[Content_Types].xml") }.to_not raise_error
        end
      end
      
      it "should generate a _rels/.rels file" do
        Zip::ZipFile.open("word.docx") do |docx|
          expect { docx.read("_rels/.rels") }.to_not raise_error
        end
      end
      
      it "should generate a word/document.xml" do
        Zip::ZipFile.open("word.docx") do |docx|
          expect { docx.read("word/document.xml") }.to_not raise_error
        end
      end
    end
  end

  describe "#paragraph" do
    it "should pass a DocxGenerator::DSL::Paragraph object to a block" do
      document = DocxGenerator::DSL::Document.new("word") do |doc|
        par_class = nil
        doc.paragraph { |par| par_class = par.class }
        par_class.should be(DocxGenerator::DSL::Paragraph)
      end
    end

    it "should add a paragraph to the document" do
      document = DocxGenerator::DSL::Document.new("word") do |doc|
        doc.paragraph { |par| }
        doc.save
      end
      open_file("word/document.xml").should include("<w:p")
    end

    it "should allow options as optional arguments" do
      document = DocxGenerator::DSL::Document.new("word") do |doc|
        doc.paragraph(alignment: :center) { |par| }
      end
    end
  end

  describe "#add" do
    it "should add the object(s) to the document" do
      doc = DocxGenerator::DSL::Document.new("word")
      doc.add DocxGenerator::DSL::Paragraph.new
      doc.save
      open_file("word/document.xml").should include("<w:p />")
    end

    it "should return the document object" do
      document = DocxGenerator::DSL::Document.new("word")
      document.add(DocxGenerator::DSL::Paragraph.new, DocxGenerator::DSL::Paragraph.new).should be(document)
    end
  end
end
