require 'spec_helper'

describe DocxGenerator::DSL::Text do
  describe "#new" do
    it "should require some text" do
      expect { DocxGenerator::DSL::Text.new }.to raise_error
    end

    context "with a block" do
      it "should pass itself to a block" do
        inner_text = nil
        text = DocxGenerator::DSL::Text.new("") do |t|
          inner_text = t
        end
        inner_text.should be(text)
      end
    end
  end

  describe "#generate" do
    it "should return a new Run with text in it" do
      text_fragment = DocxGenerator::DSL::Text.new("Title")
      text_fragment.generate.to_s.should eq("<w:r><w:t>Title</w:t></w:r>")
    end

    context "with styles" do
      it "should return a text in bold" do
        DocxGenerator::DSL::Text.new("Text", bold: true).generate.to_s.should eq("<w:r><w:rPr><w:b w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
        (DocxGenerator::DSL::Text.new("Text") { |t| t.bold true }).generate.to_s.should eq("<w:r><w:rPr><w:b w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      it "should return a text in italics" do
        DocxGenerator::DSL::Text.new("Text", italics: true).generate.to_s.should eq("<w:r><w:rPr><w:i w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
        (DocxGenerator::DSL::Text.new("Text") { |t| t.italics true }).generate.to_s.should eq("<w:r><w:rPr><w:i w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      it "should return an underlined text" do
        DocxGenerator::DSL::Text.new("Text", underline: { style: "single" }).generate.to_s.should eq("<w:r><w:rPr><w:u w:val=\"single\" /></w:rPr><w:t>Text</w:t></w:r>")
        (DocxGenerator::DSL::Text.new("Text") { |t| t.underline style: "single" }).generate.to_s.should eq("<w:r><w:rPr><w:u w:val=\"single\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      it "should return a text with a font size" do
        DocxGenerator::DSL::Text.new("Text", size: 20).generate.to_s.should eq("<w:r><w:rPr><w:sz w:val=\"40\" /></w:rPr><w:t>Text</w:t></w:r>")
        (DocxGenerator::DSL::Text.new("Text") { |t| t.size 20 }).generate.to_s.should eq("<w:r><w:rPr><w:sz w:val=\"40\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      it "should render a text in superscript" do
        DocxGenerator::DSL::Text.new("Text", superscript: true).generate.to_s.should eq("<w:r><w:rPr><w:vertAlign w:val=\"superscript\" /></w:rPr><w:t>Text</w:t></w:r>")
        (DocxGenerator::DSL::Text.new("Text") { |t| t.superscript true }).generate.to_s.should eq("<w:r><w:rPr><w:vertAlign w:val=\"superscript\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      it "should render a text in subscript" do
        DocxGenerator::DSL::Text.new("Text", subscript: true).generate.to_s.should eq("<w:r><w:rPr><w:vertAlign w:val=\"subscript\" /></w:rPr><w:t>Text</w:t></w:r>")
        (DocxGenerator::DSL::Text.new("Text") { |t| t.subscript true }).generate.to_s.should eq("<w:r><w:rPr><w:vertAlign w:val=\"subscript\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      it "shoud render a text as capital letters" do
        DocxGenerator::DSL::Text.new("Text", caps: true).generate.to_s.should eq("<w:r><w:rPr><w:caps w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
        (DocxGenerator::DSL::Text.new("Text") { |t| t.caps true }).generate.to_s.should eq("<w:r><w:rPr><w:caps w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      it "shoud render a text as small capital letters" do
        DocxGenerator::DSL::Text.new("Text", small_caps: true).generate.to_s.should eq("<w:r><w:rPr><w:smallCaps w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
        (DocxGenerator::DSL::Text.new("Text") { |t| t.small_caps true }).generate.to_s.should eq("<w:r><w:rPr><w:smallCaps w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      xit "shoud render a text with a single horizontal line through the center of the line" do
        DocxGenerator::DSL::Text.new("Text", strike: true).generate.to_s.should eq("<w:r><w:rPr><w:strike w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
        (DocxGenerator::DSL::Text.new("Text") { |t| t.strike true }).generate.to_s.should eq("<w:r><w:rPr><w:strike w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
      end

      xit "shoud render a text with two horizontal lines through the center of the line" do
        DocxGenerator::DSL::Text.new("Text", dstrike: true).generate.to_s.should eq("<w:r><w:rPr><w:dstrike w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
        (DocxGenerator::DSL::Text.new("Text") { |t| t.dstrike true }).generate.to_s.should eq("<w:r><w:rPr><w:dstrike w:val=\"true\" /></w:rPr><w:t>Text</w:t></w:r>")
      end
    end
  end

  describe "#to_s" do
    it "should render the XML representation" do
      text_fragment = DocxGenerator::DSL::Text.new("Title")
      text_fragment.to_s.should eq("<w:r><w:t>Title</w:t></w:r>")
    end
  end
end
