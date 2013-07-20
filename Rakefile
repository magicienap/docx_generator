require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new

task default: :spec
task test: :spec

desc "Run the generator passed as an argument."
task :generate, [:generator] do |_, args|
  generator = args[:generator]
  print %Q(Running "#{generator}" generator... )
  require_relative "generator/#{generator}.rb"
  puts  "done!"
end