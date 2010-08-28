require 'rake'
require 'rdoc/task'
require 'rake/gempackagetask'


desc "Run all tests by default"
task :default => :test


desc "Run tests"
task :test do
  
end


desc "Install the gem for testing locally"
task :install => :repackage do
  version = File.read("VERSION").strip
  system("gem install pkg/flit-#{version}.gem --no-ri --no-rdoc")
end


spec = eval(File.read('flit.gemspec'))
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end


desc "Push the gem to gemcutter"
task :release do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end
