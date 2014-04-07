require 'recipes'

# something like 192.168.1.0/24
set :ufw_vpn_cidr, nil

namespace :ufw do
  desc "Install the latest version of Ultimate Fire Wall"
  task :install do
    on roles(:all) do
      as :root do
        aptitude %w{ install -y ufw }
      end
    end
  end
  after "recipes:install", "ufw:install"

  desc "Setup the basic ufw rules"
  task :setup do
    as :root do
      on roles(:all) do
        execute :ufw, %w{ default deny  incoming }
        execute :ufw, %w{ default allow outgoing }
        execute :ufw, %w{ allow ssh              }
      end

      on roles(:web) do
        execute :ufw, %w{ allow http  }
        execute :ufw, %w{ allow https }
      end

      on roles(:db) do
        # postgres default port
        execute :ufw, %W{ allow from #{fetch :ufw_vpn_cidr} to any port 5432 }
      end if fetch(:ufw_vpn_cidr)
    end
  end
  after "recipes:setup", "ufw:setup"

  %w{enable disable restart reset status}.each do |command|
    desc "#{command.capitalize} ufw"
    task command do
      on roles(:all) do
        as :root do
          service 'ufw', command
        end
      end
    end
  end
end
