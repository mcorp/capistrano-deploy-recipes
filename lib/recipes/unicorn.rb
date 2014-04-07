require 'recipes'

set :unicorn_name,             nil
set :unicorn_worker_processes, 2

def unicorn_name
  fetch(:unicorn_name) || [:unicorn, application].join('_')
end

namespace :unicorn do
  desc "Install the latest stable release of unicorn"
  task :install do
    needs_implemetation
  end
  after "recipes:install", "unicorn:install"

  desc "Setup unicorn configuration for this application"
  task :setup do
    needs_implementation
  end
  after "recipes:setup", "unicorn:setup"

  %w{start stop restart}.each do |command|
    desc "#{command.capitalize} unicorn"
    task command do
      needs_implementation
    end
  end

end
