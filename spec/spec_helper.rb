require 'docx_generator'

def open_file(file)
  Zip::File.open("word.docx") do |docx|
    docx.read(file)
  end
end
