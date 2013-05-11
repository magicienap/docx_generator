require 'docx_generator'

def open_file(file)
  content = nil
  Zip::Archive.open("word.docx") do |docx|
    docx.fopen("word/document.xml") { |f| content = f.read }
  end
  content
end
