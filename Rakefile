require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test

begin
  require "hanna/rdoctask"
rescue LoadError
  require "rake/rdoctask"
end

# Generate documentation
Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("*.rdoc", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end
