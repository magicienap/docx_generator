require 'spec_helper'

describe DocxGenerator::Word::Bold do
  it "should render a w:b element" do
    DocxGenerator::Word::Bold.new.to_s.should eq("<w:b />")
    DocxGenerator::Word::Bold.new(true).to_s.should eq("<w:b w:val=\"true\" />")
    DocxGenerator::Word::Bold.new(false).to_s.should eq("<w:b w:val=\"false\" />")
  end
end

describe DocxGenerator::Word::Italics do
  it "should render a w:i element" do
    DocxGenerator::Word::Italics.new.to_s.should eq("<w:i />")
    DocxGenerator::Word::Italics.new(true).to_s.should eq("<w:i w:val=\"true\" />")
    DocxGenerator::Word::Italics.new(false).to_s.should eq("<w:i w:val=\"false\" />")
  end
end

describe DocxGenerator::Word::Underline do
  it "should render a w:u element" do
    DocxGenerator::Word::Underline.new.to_s.should eq("<w:u w:val=\"single\" />")
    DocxGenerator::Word::Underline.new(style: "double").to_s.should eq("<w:u w:val=\"double\" />")
  end
end