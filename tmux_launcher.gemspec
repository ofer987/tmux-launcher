FILES = Dir['app/**/*.rb', 'lib/**/*.rb']

Gem::Specification.new do |s|
  s.name        = 'tmux_launcher'
  s.version     = '0.1.9'
  s.date        = '2016-12-28'
  s.summary     = "TMUX Launcher"
  s.description = "A simple hello world gem"
  s.authors     = ["Dan Jakob Ofer"]
  s.email       = 'ofer987@gmail.com'
  s.require_paths = ['lib']
  s.files       = FILES
  s.executables = 'tmux_launcher'
  s.homepage    =
    'http://rubygems.org/gems/tmux_launcher'
  s.license       = 'Unlicense'
end
