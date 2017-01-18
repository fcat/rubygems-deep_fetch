require 'rubygems/command'
require 'rubygems/local_remote_options'
require 'rubygems/version_option'
require 'rubygems/dependency_resolver'

class Gem::Commands::DeepFetchCommand < Gem::Command

  include Gem::LocalRemoteOptions
  include Gem::VersionOption

  def initialize
    super 'deep_fetch', 'Download a gem and its dependencies, place them in the current directory'

    add_bulk_threshold_option
    add_proxy_option
    add_source_option
    add_clear_sources_option

    add_version_option
    add_platform_option
    # TODO add_prerelease_option
  end

  def arguments # :nodoc:
    'GEMNAME       name of gem to download'
  end

  def defaults_str # :nodoc:
    "--version '#{Gem::Requirement.default}'"
  end

  def description # :nodoc:
    <<-EOF
The deep_fetch command fetches gem files that can be stored for later use
or unpacked to examine their contents.

Unlike the built-in fetch command, deep_fetch command fetches the
dependencies but ignores the gems that are already installed.

deep_fetch is usefull to examine new packages before installing them.
    EOF
  end

  def usage # :nodoc:
    "#{program_name} GEMNAME [GEMNAME ...]"
  end

  def execute
    version = options[:version] || Gem::Requirement.default
    gem_names = get_all_gem_names

    deps = gem_names.map do |gem_name|
      Gem::Dependency.new gem_name, version
    end

    resolver = Gem::DependencyResolver.new deps;
    action_requests = resolver.resolve;

    action_requests.reject do |ar|
      ar.installed?
    end.each do |ar|
      spec = ar.spec
      full_spec = spec.spec
      source = spec.source
      source.download full_spec
      say "Downloaded #{spec.full_name}"
      spec.full_name
    end
  end

end

