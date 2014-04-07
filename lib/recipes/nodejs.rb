require 'recipes'

namespace :nodejs do

  desc "Install the latest stable version of NodeJS"
  task :install do
    on roles(:app) do
      as :root do
        # dependencies
        aptitude %w{
          install -y software-properties-common
          python-software-properties python g++ make
        }

        # adding repo with the latest stable version
        execute 'add-apt-repository', 'ppa:chris-lea/node.js'
        aptitude :update

        # installing nodejs
        aptitude %w{ install -y nodejs }
      end
    end
  end
  after "recipes:install", "nodejs:install"

end
