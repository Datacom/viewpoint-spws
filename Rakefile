require 'rubygems'
require 'rake/clean'
require 'rake/gempackagetask'

CLEAN.include("pkg")
CLEAN.include("doc")

GEMSPEC = Gem::Specification.new do |gem|
  gem.name = "viewpoint_spws"
  gem.version = File.open('VERSION').readline.chomp
  gem.date		= Date.today.to_s
  gem.platform = Gem::Platform::RUBY
  gem.rubyforge_project  = nil

  gem.author = "Dan Wanek"
  gem.email = "dan.wanek@gmail.com"
  gem.homepage = "http://github.com/zenchild/viewpoint_spws"

  gem.summary = "A Ruby client access library for Microsoft Sharepoint Web Services (SPWS)"
  gem.description	= <<-EOF
  	A Ruby client access library for Microsoft Sharepoint Web Services (SPWS).  It is a work in progress.  Methods are still being added from the Sharepoint API docs.
  EOF

  gem.files = `git ls-files`.split(/\n/)
  gem.require_path = "lib"
#  gem.rdoc_options	= %w(-x wsdl/ -x test/ -x examples/)
  gem.extra_rdoc_files = %w(README.markdown COPYING.txt)

  gem.required_ruby_version	= '>= 1.8.7'
  gem.add_runtime_dependency  'handsoap'
  gem.add_runtime_dependency  'rubyntlm', '>=0.1.1'
  gem.post_install_message	= "Don't forget to create .viewpointrc.  See README"
end
 
Rake::GemPackageTask.new(GEMSPEC) do |pkg|
  pkg.need_tar = true
end

task :default => [:buildgem]

desc "Build the gem without a version change"
task :buildgem => [:clean, :repackage]

desc "Build the gem, but increment the version first"
task :newrelease => [:versionup, :clean, :repackage]


desc "Increment the version by 1 minor release"
task :versionup do
	ver = up_min_version
	puts "New version: #{ver}"
end


def up_min_version
	f = File.open('VERSION', 'r+')
	ver = f.readline.chomp
	v_arr = ver.split(/\./).map do |v|
		v.to_i
	end
	v_arr[2] += 1
	ver = v_arr.join('.')
	f.rewind
	f.write(ver)
	ver
end
