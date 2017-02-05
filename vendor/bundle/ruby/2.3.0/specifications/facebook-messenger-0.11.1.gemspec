# -*- encoding: utf-8 -*-
# stub: facebook-messenger 0.11.1 ruby lib

Gem::Specification.new do |s|
  s.name = "facebook-messenger".freeze
  s.version = "0.11.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Johannes Gorset".freeze]
  s.bindir = "exe".freeze
  s.date = "2016-11-23"
  s.description = "Facebook Messenger client".freeze
  s.email = ["jgorset@gmail.com".freeze]
  s.homepage = "https://github.com/hyperoslo/facebook-messenger".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.10".freeze
  s.summary = "Facebook Messenger client".freeze

  s.installed_by_version = "2.6.10" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>.freeze, [">= 0.13.7", "~> 0.13"])
      s.add_runtime_dependency(%q<rack>.freeze, [">= 1.6.4"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.11"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.4"])
      s.add_development_dependency(%q<rack-test>.freeze, ["~> 0.6.3"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.39"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 1.24"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 11.0"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    else
      s.add_dependency(%q<httparty>.freeze, [">= 0.13.7", "~> 0.13"])
      s.add_dependency(%q<rack>.freeze, [">= 1.6.4"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.11"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
      s.add_dependency(%q<rack-test>.freeze, ["~> 0.6.3"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.39"])
      s.add_dependency(%q<webmock>.freeze, ["~> 1.24"])
      s.add_dependency(%q<rake>.freeze, ["~> 11.0"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>.freeze, [">= 0.13.7", "~> 0.13"])
    s.add_dependency(%q<rack>.freeze, [">= 1.6.4"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.11"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
    s.add_dependency(%q<rack-test>.freeze, ["~> 0.6.3"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.39"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.24"])
    s.add_dependency(%q<rake>.freeze, ["~> 11.0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
  end
end
