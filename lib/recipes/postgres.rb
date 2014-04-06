require 'recipes'

namespace :postgres do

  desc "Install the latest stable release of postgres"
  task :install do
    needs_implemetation
  end
  after "recipes:install", "postgres:install"

  desc "Setup postgres configuration for this application"
  task :setup do
    needs_implementation
  end
  after "recipes:setup", "postgres:setup"

  %w{start stop restart}.each do |command|
    desc "#{command.capitalize} postgres"
    task status do
      needs_implementation
    end
  end

end
