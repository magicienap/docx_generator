require 'docx_generator'

def open_file(file)
  Zip::ZipFile.open("word.docx") do |docx|
    docx.read(file)
  end
end
