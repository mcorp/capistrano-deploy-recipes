require 'sshkit_extensions'

namespace :recipes do
  desc "Install selected recipes on remote server"
  task :install do
    on roles(:all) do
      as :root do
        aptitude :update
        aptitude %w{
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
