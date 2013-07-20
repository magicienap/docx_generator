class Generate < Thor

  desc "word_base", "Generate the word/base.rb file with his spec file."
  def word_base
    require_relative 'generators/word_base'
  end
end