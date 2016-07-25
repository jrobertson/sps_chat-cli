Gem::Specification.new do |s|
  s.name = 'sps_chat-cli'
  s.version = '0.1.0'
  s.summary = 'A simplistic interactive chat console using the sps_chat gem.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/sps_chat-cli.rb']
  s.add_runtime_dependency('sps_chat', '~> 0.1', '>=0.1.1')
  s.signing_key = '../privatekeys/sps_chat-cli.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/sps_chat-cli'
end
