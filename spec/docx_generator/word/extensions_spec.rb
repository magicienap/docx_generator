require 'spec_helper'

describe DocxGenerator::Word::Extensions do
  describe "space" do
    it "should render a space" do
      DocxGenerator::Word::Extensions.space.to_s.should eq("<w:r><w:t xml:space=\"preserve\"> </w:t></w:r>")
    end
  end

  describe "newline" do
    it "should render a newline" do
      DocxGenerator::Word::Extensions::Newline.new.generate.to_s.should eq("<w:r><w:br /></w:r>")
    end
  end
end
