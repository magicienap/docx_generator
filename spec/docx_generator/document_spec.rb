require 'spec_helper'

describe DocxGenerator::Document do
  it "should create a new docx document with the filename specified" do
    document = DocxGenerator::Document.new("word")
    document.filename.should eq("word.docx")
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
  
  describe "#add_paragraph" do
    let(:document) { DocxGenerator::Document.new("word") }

    after do
      File.delete("word.docx") if File.exists?("word.docx")
    end
  
    it "should add a paragraph with the fragments supplied separated by a space" do
      document.add_paragraph("The first characters", "and the last ones.").save
      open_file("word/document.xml").should include("<w:p><w:r><w:t>The first characters</w:t></w:r><w:r><w:t xml:space=\"preserve\"> </w:t></w:r><w:r><w:t>and the last ones.</w:t></w:r></w:p>")
    end

    it "should not add a space when it encounters :no_space" do
      document.add_paragraph("CO", :no_space, "2").save
      open_file("word/document.xml").should include("<w:p><w:r><w:t>CO</w:t></w:r><w:r><w:t>2</w:t></w:r></w:p>")
    end
    
    # To be modified with bold and italics
    it "should add a paragraph with a formatted text" do
      document.add_paragraph(document.text("The first characters"), "and the last ones.").save
      open_file("word/document.xml").should include("<w:p><w:r><w:t>The first characters</w:t></w:r><w:r><w:t xml:space=\"preserve\"> </w:t></w:r><w:r><w:t>and the last ones.</w:t></w:r></w:p>")
    end
    
    it "should return the current document" do
      document.add_paragraph(["The first characters", "and the last ones."]).should be(document)
    end

    context "with styles" do
      it "should align the paragraph" do
        document.add_paragraph(document.text("The first characters"), "and the last ones.", alignment: "center").save
        open_file("word/document.xml").should include("<w:p><w:pPr><w:jc w:val=\"center\" /></w:pPr><w:r><w:t>The first characters</w:t></w:r><w:r><w:t xml:space=\"preserve\"> </w:t></w:r><w:r><w:t>and the last ones.</w:t></w:r></w:p>")
      end
    end
  end
  
  describe "#text" do
    it "should return a new Run with text in it" do
      DocxGenerator::Document.new("word").text("Text").to_s.should eq("<w:r><w:t>Text</w:t></w:r>")
    end
    
    context "with styles" do
      it "should return a text in bold" do
        DocxGenerator::Document.new("word").text("Text", bold: true).to_s.should eq("<w:r><w:rPr><w:b w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
      end
      
      it "should return a text in italics" do
        DocxGenerator::Document.new("word").text("Text", italics: true).to_s.should eq("<w:r><w:rPr><w:i w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
      end
      
      it "should return an underlined text" do
        DocxGenerator::Document.new("word").text("Text", underline: { style: "single" }).to_s.should eq("<w:r><w:rPr><w:u w:val=\"single\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      it "should return a text with a font size" do
        DocxGenerator::Document.new("word").text("Text", size: 20).to_s.should eq("<w:r><w:rPr><w:sz w:val=\"40\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      it "should render a text in superscript" do
        DocxGenerator::Document.new("word").text("Text", superscript: true).to_s.should eq("<w:r><w:rPr><w:vertAlign w:val=\"superscript\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      it "should render a text in subscript" do
        DocxGenerator::Document.new("word").text("Text", subscript: true).to_s.should eq("<w:r><w:rPr><w:vertAlign w:val=\"subscript\" /></w:rPr><w:t>Text</w:t></w:r>")
      end
    end
  end
end
