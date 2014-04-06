require 'recipes'

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
    task status do
      needs_implementation
    end
  end

end
