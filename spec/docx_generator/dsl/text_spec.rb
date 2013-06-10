require 'spec_helper'

describe DocxGenerator::DSL::Text do
  context "with a block" do
    it "should pass itself to a block" do
      inner_text = nil
      text = DocxGenerator::DSL::Text.new("") do |t|
        inner_text = t
      end
      inner_text.should be(text)
    end
  end

  it "should require some text" do
    expect { DocxGenerator::DSL::Text.new }.to raise_error
  end

  describe "#generate" do
    it "should generate the text fragment" do
      document = DocxGenerator::Document.new("word")
      text_fragment = DocxGenerator::DSL::Text.new("Title")
      text_fragment.generate(document).generate.should include("<w:t")
    end
  end
end
