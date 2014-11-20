$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ankaa-content/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ankaa-content'
  s.version     = AnkaaContent::VERSION
  s.authors     = 'whiteboxteam'
  s.email       = 'support@whiteboxteam.com'
  s.homepage    = ''
  s.summary     = ''
  s.description = ''
  s.license     = 'MIT'

  s.files = Dir['{app,db,lib}/**/*', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.1.1'
  s.add_dependency 'paperclip'
  s.add_dependency 'ankaa-statistic'

  s.add_development_dependency 'pg'
end
