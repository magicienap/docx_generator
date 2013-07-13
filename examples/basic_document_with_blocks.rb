require 'docx_generator'

DocxGenerator::DSL::Document.new("basic_paragraph") do |doc|
  doc.paragraph do |par|
    par.alignment :center
    par.text "Title" do |t|
      t.underline style: "double"
      t.size 20
      t.caps true
    end
    # par.newline
  end

  doc.paragraph do |par|
    par.text "Simple string of text and"
    par.text "some formatted text" do |t|
      t.bold true
      t.italics true
      t.underline style: "single"
    end
  end

  doc.paragraph do |par|
    par.text "Antoine", bold: true, small_caps: true
    par.text "How are you today?"
  end

  doc.paragraph do |par|
    par.text "John", bold: true, small_caps: true
    par.text "(whispering)", bold: true, italics: true
    par.text "How are you today?"
  end

  doc.paragraph(alignment: :center) do |par|
    par.text "A simple chemical formula: CO"
    par.no_space
    par.text "2", subscript: true
  end
  
  doc.save
end