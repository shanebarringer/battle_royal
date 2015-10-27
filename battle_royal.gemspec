Gem::Specification.new do |x|
  x.name         = "battle_royal"
  x.version      = "1.0.0"
  x.author       = "@shanebarringer"
  x.email        = "shane.barringer@outlook.com"
  x.homepage     = "https://github.com/shanebarringer/battle_royal"
  x.summary      = "A Mortal Kombat influenced Battle Royal"
  x.description  = File.read(File.join(File.dirname(__FILE__), 'README.md'))
  x.licenses     = ['MIT']

  x.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README.md)
  x.test_files    = Dir["spec/**/*"]
  x.executables   = [ 'battle' ]

  x.required_ruby_version = '>=1.9'
  x.add_development_dependency 'rspec'
end
