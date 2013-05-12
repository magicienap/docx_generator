# DocxGenerator

A gem to generate docx files.

## Installation

Add this line to your application's Gemfile:

    gem 'docx_generator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install docx_generator

## Usage

To create a new docx file and save it, just type:

```ruby
require 'docx_generator'

DocxGenerator::Document.new("filename").save # Will save the document to filename.docx
```

To create a paragraph and add formatted text to it:

```ruby
require 'docx_generator'

document = DocxGenerator::Document.new("filename")
document.add_paragraph("Simple string of text and", document.text("some formatted text", bold: true, italics: true)) # The fragments will be separated by a space when they will be rendered
document.save
```

You can see more examples in the `examples` directory.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/557c5048ed09993a48f60e0aa0869ab3 "githalytics.com")](http://githalytics.com/magicienap/docx_generator)
