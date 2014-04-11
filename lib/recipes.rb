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

def template!(from, to, options = {})
  template_file = expand_template_filename from
  template      = File.read template_file
  temp_file     = File.join(fetch(:tmp_dir), File.basename(to))

  upload! StringIO.new(ERB.new(template).result(binding)), temp_file

  # FIXME this is kind of dangerous
  # https://github.com/capistrano/sshkit/blob/master/lib/sshkit/backends/abstract.rb#L95
  ownership = "#{options[:user] || @user}:#{options[:group] || @group}"
  mode      = options[:mode] || 'a+r'

  execute :mv,    temp_file, to
  execute :chown, ownership, to
  execute :chmod, mode,      to

  info "Generated file at #{to} using template #{template_file}"
end

def expand_template_filename(template)
  template = File.expand_path "../templates/#{template}", __FILE__
  template << '.erb' if File.extname(template).empty?
  template
end
