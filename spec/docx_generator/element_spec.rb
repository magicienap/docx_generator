require 'spec_helper'

describe DocxGenerator::Element do
  it "should create a new XML element given a name, optional arguments and an optional content" do
    DocxGenerator::Element.new("w:document")
    DocxGenerator::Element.new("w:document", { "xmlns:w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main" })
    DocxGenerator::Element.new("w:document", { "xmlns:w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main" }, [DocxGenerator::Element.new("w:body")])
  end
  
  describe "#add" do
    it "should add a child to the element" do
      element = DocxGenerator::Element.new("w:document")
      element.add DocxGenerator::Element.new("w:body")
    end
  end
  
  describe "#generate" do
    context "without arguments and children" do
      it "should render a self-closing XML tag" do
        DocxGenerator::Element.new("w:document").generate.should eq("<w:document />")
      end
    end
    
    context "with arguments" do
      it "should render a self-closing XML tag with the arguments" do
        DocxGenerator::Element.new("w:document", { "xmlns:w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main" }).generate.should eq("<w:document xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" />")
      end
    end
    
    context "with arguments and children" do
      it "should render the XML element with the arguments and the generated children" do
        DocxGenerator::Element.new("w:document", { "xmlns:w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main" }, [DocxGenerator::Element.new("w:body")]).generate.should eq("<w:document xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\"><w:body /></w:document>")
        
        DocxGenerator::Element.new("w:document", { "xmlns:w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main" }, ["Text"]).generate.should eq("<w:document xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\">Text</w:document>")
      end
    end
  end
  
  describe "#to_s" do
    it "should render the XML element in a string" do
      DocxGenerator::Element.new("w:document", { "xmlns:w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main" }, [DocxGenerator::Element.new("w:body")]).to_s.should eq("<w:document xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\"><w:body /></w:document>")
    end
  end
end
