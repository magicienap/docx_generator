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

describe DocxGenerator::Word::Size do
  it "should render a w:sz element" do
    DocxGenerator::Word::Size.new(20).to_s.should eq("<w:sz w:val=\"40\" />")
  end
end

describe DocxGenerator::Word::Alignment do
  it "should render a w:jc element" do
    DocxGenerator::Word::Alignment.new("center").to_s.should eq("<w:jc w:val=\"center\" />")
  end
end

describe DocxGenerator::Word::Spacing do
  it "should render a w:spacing element" do
    DocxGenerator::Word::Spacing.new(line: 1.15).to_s.should eq("<w:spacing w:line=\"276\" w:lineRule=\"auto\" />")
    DocxGenerator::Word::Spacing.new(before: 12, after: 12, line: 1.15).to_s.should eq("<w:spacing w:before=\"240\" w:after=\"240\" w:line=\"276\" w:lineRule=\"auto\" />")
  end
end

describe DocxGenerator::Word::Indentation do
  it "should render a w:spacing element" do
    DocxGenerator::Word::Indentation.new(start: 20, end: 20, first_line: 20).to_s.should eq("<w:ind w:start=\"400\" w:end=\"400\" w:firstLine=\"400\" />")
    DocxGenerator::Word::Indentation.new(start: 20, end: 20, hanging: 20).to_s.should eq("<w:ind w:start=\"400\" w:end=\"400\" w:hanging=\"400\" />")
  end
end

describe DocxGenerator::Word::Tabs do
  it "should render a w:tabs element" do
    DocxGenerator::Word::Tabs.new([{ leader: "dot", pos: 72, val: "end" }, { leader: "underscore", pos: 144, val: "start" }]).to_s.should eq(%q[<w:tabs><w:tab w:leader="dot" w:pos="1440" w:val="end" /><w:tab w:leader="underscore" w:pos="2880" w:val="start" /></w:tabs>])
  end
end

describe DocxGenerator::Word::Tab do
  it "should render a w:tab element" do
    DocxGenerator::Word::Tab.new({ leader: "dot", pos: 72, val: "end" }).to_s.should eq(%q[<w:tab w:leader="dot" w:pos="1440" w:val="end" />])
  end
end

describe DocxGenerator::Word::VerticalAlign do
  it "should render a w:vertAlign element" do
    DocxGenerator::Word::VerticalAlign.new("superscript").to_s.should eq("<w:vertAlign w:val=\"superscript\" />")
  end
end

describe DocxGenerator::Word::CapitalLetters do
  it "should render a w:caps element" do
    DocxGenerator::Word::CapitalLetters.new.to_s.should eq("<w:caps />")
    DocxGenerator::Word::CapitalLetters.new(true).to_s.should eq("<w:caps w:val=\"true\" />")
    DocxGenerator::Word::CapitalLetters.new(false).to_s.should eq("<w:caps w:val=\"false\" />")
  end
end

describe DocxGenerator::Word::SmallCapitalLetters do
  it "should render a w:caps element" do
    DocxGenerator::Word::SmallCapitalLetters.new.to_s.should eq("<w:smallCaps />")
    DocxGenerator::Word::SmallCapitalLetters.new(true).to_s.should eq("<w:smallCaps w:val=\"true\" />")
    DocxGenerator::Word::SmallCapitalLetters.new(false).to_s.should eq("<w:smallCaps w:val=\"false\" />")
  end
end

describe DocxGenerator::Word::Font do
  it "should render a w:rFonts element" do
    DocxGenerator::Word::Font.new("Trebuchet MS").to_s.should eq("<w:rFonts w:ascii=\"Trebuchet MS\" />")
  end
end