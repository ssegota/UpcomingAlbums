# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "db_api"
  spec.version       = '1.0'
  spec.authors       = ["Sandi Šegota, Ines Krnjus"]
  spec.email         = ["ssegota@gmail.com, ikrnjus@riteh.hr"]
  spec.summary       = %q{Search and update database of upcomingmusic album data}
  spec.description   = %q{This projects gives you a web API to seearch and add new upcoiming musical albums. It enables you to search them by genre, date, location, musician and subgenre of album.}
  spec.homepage      = "http://"
  spec.license       = "GPL"

  spec.files         = ['lib/db_api.rb']
  spec.executables   = ['bin/db_api']
  spec.test_files    = ['tests/test_db_api.rb']
  spec.require_paths = ["lib"]
end
