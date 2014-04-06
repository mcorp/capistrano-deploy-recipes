require 'recipes'

namespace :postgres do

  desc "Install the latest stable release of postgres"
  task :install do
    on roles(:db), only: { primary: true } do
      as :root do
        execute 'add-apt-repository', 'ppa:pitti/postgresql'
        aptitude %w{ -y update }
        aptitude %w{ -y install postgresql-9.3 postgresql-contrib-9.3 postgresql-client-9.3 libpq-dev postgresql-server-dev-9.3 }
      end
    end
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
