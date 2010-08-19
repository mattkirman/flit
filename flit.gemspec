version = File.read(File.expand_path("../VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'flit'
  s.version     = version
  s.summary     = ''
  s.description = ''
  
  s.required_ruby_version     = '>= 1.8.7'
  s.required_rubygems_version = ">= 1.3.6"
  
  s.author            = 'Matt Kirman'
  s.email             = 'matt@mattkirman.com'
  s.homepage          = 'http://mattkirman.com/projects/flit'
  
  s.bindir             = 'bin'
  s.executables        = ['flit']
  s.default_executable = 'flit'
end