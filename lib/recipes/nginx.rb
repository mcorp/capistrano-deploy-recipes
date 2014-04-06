require 'recipes'

namespace :nginx do

  desc "Install the latest stable release of nginx"
  task :install do
    needs_implemetation
  end
  after "recipes:install", "nginx:install"

  desc "Setup nginx configuration for this application"
  task :setup do
    needs_implementation
  end
  after "recipes:setup", "nginx:setup"

  %w{start stop restart}.each do |command|
    desc "#{command.capitalize} nginx"
    task command do
      on roles(:web) do
        as :root do
          execute :services, 'nginx', command
        end
      end
    end
  end

end
