require 'sshkit_extensions'

namespace :recipes do
  desc "Install selected recipes on remote server"
  task :install do
    on roles(:all) do
      as :root do
        aptitude :update
        aptitude %w{
          install -y
          software-properties-common python-software-properties curl wget git
        }
      end
    end
  end

  desc "Setup selected recipes on remote server"
  task :setup do
    # no actual action happens here
  end
end

def needs_implementation
  puts "Needs to be implemented +_+"
end

# Keeps only a..zA..Z0..9_
def application
  @application ||= fetch(:application).gsub(/\W/,'')
end

def template!(from, to)
  template_file = File.expand_path("../templates/#{from}", __FILE__)
  template_file << '.erb' if File.extname(template_file).empty?
  template      = File.read template_file
  temp_file     = File.join(fetch(:tmp_dir), File.basename(to))

  upload! StringIO.new(ERB.new(template).result(binding)), temp_file

  execute :chown, 'root:',   temp_file
  execute :chmod, 'a+r',     temp_file
  execute :mv,    temp_file, to

  info "Generated file at #{to} using template #{template_file}"
end
