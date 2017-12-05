Gem::Specification.new do |s|
  s.name        = 'wondeclient'
  s.version     = '0.0.7'
  s.date        = '2017-12-05'
  s.summary     = "Wonde Client"
  s.description = "Wonde Client"
  s.authors     = ["Mike Donlon"]
  s.email       = 'miked63017@gmail.com '
  files = []
  dirs = %w{lib}
  dirs.each do |dir|
    files += Dir["#{dir}/**/*"]
  end
  s.add_dependency 'unirest', "~> 1.1.2"
  s.files       = files
  s.homepage    = 'https://github.com/wondeltd'
  s.license       = 'MIT'

  #s.bindir = "bin"
  s.executables << "wondeclient".downcase

end
