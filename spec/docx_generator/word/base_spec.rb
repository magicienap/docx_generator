require 'spec_helper'

describe DocxGenerator::Word::Document do
  it "should render a w:document element" do
    DocxGenerator::Word::Document.new.to_s.should eq("<w:document />")
    DocxGenerator::Word::Document.new({}, ["Text"]).to_s.should eq("<w:document>Text</w:document>")
    DocxGenerator::Word::Document.new({ "w:conformance" => "strict" }, ["Text"]).to_s.should eq("<w:document w:conformance=\"strict\">Text</w:document>")
  end
end

describe DocxGenerator::Word::Body do
  it "should render a w:body element" do
    DocxGenerator::Word::Body.new.to_s.should eq("<w:body />")
    DocxGenerator::Word::Body.new({}, ["Text"]).to_s.should eq("<w:body>Text</w:body>")
  end
end

describe DocxGenerator::Word::Paragraph do
  it "should render a w:p element" do
    DocxGenerator::Word::Paragraph.new.to_s.should eq("<w:p />")
    DocxGenerator::Word::Paragraph.new({}, ["Text"]).to_s.should eq("<w:p>Text</w:p>")
  end
end

describe DocxGenerator::Word::ParagraphProperties do
  it "should render a w:pPr element" do
    DocxGenerator::Word::ParagraphProperties.new.to_s.should eq("<w:pPr />")
    DocxGenerator::Word::ParagraphProperties.new({}, ["Text"]).to_s.should eq("<w:pPr>Text</w:pPr>")
  end
end

describe DocxGenerator::Word::Run do
  it "should render a w:r element" do
    DocxGenerator::Word::Run.new.to_s.should eq("<w:r />")
    DocxGenerator::Word::Run.new({}, ["Text"]).to_s.should eq("<w:r>Text</w:r>")
  end
end

describe DocxGenerator::Word::RunProperties do
  it "should render a w:rPr element" do
    DocxGenerator::Word::RunProperties.new.to_s.should eq("<w:rPr />")
    DocxGenerator::Word::RunProperties.new({}, ["Text"]).to_s.should eq("<w:rPr>Text</w:rPr>")
  end
end

describe DocxGenerator::Word::Text do
  it "should render a w:t element" do
    DocxGenerator::Word::Text.new.to_s.should eq("<w:t />")
    DocxGenerator::Word::Text.new({}, ["Text"]).to_s.should eq("<w:t>Text</w:t>")
  end
end
