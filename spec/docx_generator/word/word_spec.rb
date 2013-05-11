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
