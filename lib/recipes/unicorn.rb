require 'recipes'

set :unicorn_name,             nil
set :unicorn_worker_processes, 2
set :unicorn_timeout, 30

def unicorn_name
  fetch(:unicorn_name) || [:unicorn, application].join('_')
end

def unicorn_timeout
  fetch(:unicorn_timeout) || 60
end

namespace :unicorn do
  desc "Install the latest stable release of unicorn"
  task :install do
    needs_implementation
  end
  after "recipes:install", "unicorn:install"

  desc "Setup unicorn configuration for this application"
  task :setup do
    on roles(:app) do
      as :root do
        # FIXME shouldn't it be locally generated? or on shared/config?
        template! 'unicorn.rb', "#{current_path}/config/unicorn.rb"
        template! 'unicorn_init', "/etc/init.d/#{unicorn_name}"
        template! 'unicorn_init.conf', "/etc/init/#{unicorn_name}.conf"
      end
    end
  end
  after "recipes:setup", "unicorn:setup"

  %w{start stop restart}.each do |command|
    desc "#{command.capitalize} unicorn"
    task command do
      needs_implementation
    end
  end

end
