require 'spec_helper'

describe DocxGenerator::DSL::Paragraph do
  it "should pass itself to a block" do
    inner_par = nil
    paragraph = DocxGenerator::DSL::Paragraph.new do |par|
      inner_par = par
    end
    inner_par.should be(paragraph)
  end

  describe "#generate" do
    it "should generate the paragraph" do
      document = DocxGenerator::Document.new("word")

      paragraph = DocxGenerator::DSL::Paragraph.new { |par| }
      paragraph.generate(document)
      document.save
      open_file("word/document.xml").should include("<w:p")
    end
  end

  describe "#text" do
    context "with a block" do
      it "should pass a DocxGenerator::DSL::Text object to a block" do
        paragraph = DocxGenerator::DSL::Paragraph.new do |par|
          text_class = nil
          par.text("") { |t| text_class = t.class }
          text_class.should be(DocxGenerator::DSL::Text)
        end
      end
    end

    it "should add a text fragment to the paragraph" do
      document = DocxGenerator::DSL::Document.new("word") do |doc|
        doc.paragraph do |par|
          par.text "Title"
        end
        doc.save
      end
      open_file("word/document.xml").should include("<w:p><w:r><w:t>Title</w:t></w:r></w:p>")
    end
  end

  describe "#alignment" do
    it "should add the alignment property to the paragraph"
  end
end
