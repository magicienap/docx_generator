require 'docx_generator'
include DocxGenerator::DSL

doc = DocxGenerator::Document.new("basic_paragraph")
doc.add Paragraph.new(alignment: "center").add(Text.new("Title", underline: { style: "double" }, size: 20), Extensions::Newline.new)
doc.add Paragraph.new.add(Text.new("Simple string of text and"), Text.new("some formatted text"), bold: true, italics: true, underline: { style: "single" })
doc.add Paragraph.new.add(Text.new("Antoine", bold: true), Text.new("How are you today?"))
doc.add Paragraph.new.add(Text.new("John", bold: true), Text.new("(whispering)", bold: true, italics: true), Text.new("How are you today"))
doc.add Paragraph.new(alignment: "center").add(Text.new("A simple chemical formula: CO"), Extensions::NoSpace.new, Text.new("2", subscript: true))
doc.save