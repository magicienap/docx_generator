require 'spec_helper'

describe DocxGenerator::Document do
  it "should create a new docx document with the filename specified" do
    document = DocxGenerator::Document.new("word")
    document.filename.should eq("word")
  end
end
