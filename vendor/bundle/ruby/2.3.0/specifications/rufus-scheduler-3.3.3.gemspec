# -*- encoding: utf-8 -*-
# stub: rufus-scheduler 3.3.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rufus-scheduler".freeze
  s.version = "3.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Mettraux".freeze]
  s.date = "2017-01-29"
  s.description = "job scheduler for Ruby (at, cron, in and every jobs).".freeze
  s.email = ["jmettraux@gmail.com".freeze]
  s.homepage = "http://github.com/jmettraux/rufus-scheduler".freeze
  s.licenses = ["MIT".freeze]
  s.rubyforge_project = "rufus".freeze
  s.rubygems_version = "2.6.10".freeze
  s.summary = "job scheduler for Ruby (at, cron, in and every jobs)".freeze

  s.installed_by_version = "2.6.10" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tzinfo>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 2.13.0"])
      s.add_development_dependency(%q<chronic>.freeze, [">= 0"])
    else
      s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 2.13.0"])
      s.add_dependency(%q<chronic>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.13.0"])
    s.add_dependency(%q<chronic>.freeze, [">= 0"])
  end
end
