version = File.read(File.expand_path("../VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'flit'
  s.version     = version
  s.summary     = 'Git extension manager'
  s.description = 'Flit is a super simple extension manager for Git. It aims to give quick repository functions to improve a typical Git workflow.'
  
  s.required_ruby_version     = '>= 1.8.7'
  s.required_rubygems_version = ">= 1.3.6"
  
  s.author            = 'Matt Kirman'
  s.email             = 'matt@mattkirman.com'
  s.homepage          = 'http://github.com/mattkirman/flit'
  
  s.bindir             = 'bin'
  s.executables        = ['flit']
  s.default_executable = 'flit'
  
  s.files = Dir["History.txt", "LICENCE", "Rakefile", "README.md", "VERSION","lib/*.rb", "lib/flit/*.rb", "lib/flit/**/*.rb"]
  
  s.add_dependency('highline')
end