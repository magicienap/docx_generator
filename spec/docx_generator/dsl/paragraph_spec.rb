require 'spec_helper'

describe DocxGenerator::DSL::Paragraph do
  describe "#new" do
    context "with a block" do
      it "should pass itself to a block" do
        inner_par = nil
        paragraph = DocxGenerator::DSL::Paragraph.new do |par|
          inner_par = par
        end
        inner_par.should be(paragraph)
      end
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

    it "should allow options as optional arguments" do
      paragraph = DocxGenerator::DSL::Paragraph.new do |par|
        par.text "Title", underline: { style: "double" }, size: 20
      end
    end
  end

  describe "#generate" do
    it "should return a new paragraph with rich text fragments in it separated by a space" do
      paragraph = DocxGenerator::DSL::Paragraph.new.add(DocxGenerator::DSL::Text.new("The first characters"), DocxGenerator::DSL::Text.new("and the last ones."))
      paragraph.generate.to_s.should eq("<w:p><w:r><w:t>The first characters</w:t></w:r><w:r><w:t xml:space=\"preserve\"> </w:t></w:r><w:r><w:t>and the last ones.</w:t></w:r></w:p>")
    end

    it "should not add a space when it encounters a NoSpace object" do
      paragraph = DocxGenerator::DSL::Paragraph.new.add(DocxGenerator::DSL::Text.new("CO"), DocxGenerator::Word::Extensions::NoSpace.new, DocxGenerator::DSL::Text.new("2"))
      paragraph.generate.to_s.should eq("<w:p><w:r><w:t>CO</w:t></w:r><w:r><w:t>2</w:t></w:r></w:p>")

      paragraph = DocxGenerator::DSL::Paragraph.new do |p|
        p.text "CO"
        p.no_space
        p.text "2"
      end
      paragraph.generate.to_s.should eq("<w:p><w:r><w:t>CO</w:t></w:r><w:r><w:t>2</w:t></w:r></w:p>")
    end

    context "with styles" do
      it "should align the paragraph" do
        DocxGenerator::DSL::Paragraph.new(alignment: "center").add(DocxGenerator::DSL::Text.new("The first characters"), DocxGenerator::DSL::Text.new("and the last ones.")).generate.to_s.should eq("<w:p><w:pPr><w:jc w:val=\"center\" /></w:pPr><w:r><w:t>The first characters</w:t></w:r><w:r><w:t xml:space=\"preserve\"> </w:t></w:r><w:r><w:t>and the last ones.</w:t></w:r></w:p>")
        (DocxGenerator::DSL::Paragraph.new { |p| p.alignment "center" }).add(DocxGenerator::DSL::Text.new("The first characters"), DocxGenerator::DSL::Text.new("and the last ones.")).generate.to_s.should eq("<w:p><w:pPr><w:jc w:val=\"center\" /></w:pPr><w:r><w:t>The first characters</w:t></w:r><w:r><w:t xml:space=\"preserve\"> </w:t></w:r><w:r><w:t>and the last ones.</w:t></w:r></w:p>")
      end
    end
  end

  describe "#add" do
    it "should add the object(s) to the paragraph" do
      paragraph = DocxGenerator::DSL::Paragraph.new.add(DocxGenerator::DSL::Text.new("The first characters"), DocxGenerator::DSL::Text.new("and the last ones."))
      paragraph.generate.to_s.should eq("<w:p><w:r><w:t>The first characters</w:t></w:r><w:r><w:t xml:space=\"preserve\"> </w:t></w:r><w:r><w:t>and the last ones.</w:t></w:r></w:p>")
    end

    it "should return the paragraph object" do
      paragraph = DocxGenerator::DSL::Paragraph.new
      paragraph.add(DocxGenerator::DSL::Text.new("The first characters"), DocxGenerator::DSL::Text.new("and the last ones.")).should be(paragraph)
    end
  end
end
