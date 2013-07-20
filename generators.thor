class Generate < Thor

  desc "word_base", "Generate the word/base.rb file with its spec file."
  def word_base
    require './generators/word_base'

    invoke 'word_base:code'
    invoke 'word_base:spec'
  end
end