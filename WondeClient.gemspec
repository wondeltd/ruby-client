Gem::Specification.new do |s|
  s.name        = 'wondeclient'
  s.version     = '0.2.2'
  s.date        = '2019-11-15'
  s.summary     = "Wonde Client"
  s.description = "Wonde Client"
  s.authors     = ["Mike Donlon"]
  s.email       = 'miked63017@gmail.com '
  files = []
  dirs = %w{lib}
  dirs.each do |dir|
    files += Dir["#{dir}/**/*"]
  end
  s.add_dependency 'rest-client', "~> 2.0"
  s.add_dependency 'addressable', "~> 2.5"


Gem::Specification.new do |s|
  s.add_development_dependency 'pry'
  s.add_development_dependency 'debugger'
  s.add_development_dependency 'rake'
end
  s.files       = files
  s.homepage    = 'https://github.com/wondeltd'
  s.license       = 'MIT'

  #s.bindir = "bin"
  s.executables << "wondeclient".downcase

end
