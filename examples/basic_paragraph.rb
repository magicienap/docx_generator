require 'docx_generator'

document = DocxGenerator::Document.new("basic_paragraph")
document.add_paragraph(document.text("Title", underline: { style: "double" }, size: 20))
document.add_paragraph("Simple string of text and", document.text("some formatted text", bold: true, italics: true, underline: { style: "single" }))
document.add_paragraph(document.text("Antoine", bold: true), "How are you today?")
document.add_paragraph(document.text("John", bold: true), document.text("(whispering)", bold: true, italics: true), "How are you today?")
document.save
