require 'recipes'

set :ruby_version, '2.1.1'

namespace :ruby do

  desc "Installs ruby #{fetch :ruby_version}"
  task :install do
    on roles(:app, :web) do
      as :root do
        # update de package manager
        aptitude :update

        # installation task dependencies
        aptitude %w{ install -y wget }

        # ruby dependencies
        aptitude %w{
          install -y build-essential openssl libreadline6 libreadline6-dev
          zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt1-dev
          autoconf libc6-dev libncurses5-dev automake libtool bison libffi-dev
          imagemagick
        }

        # acquiring ruby
        within '/tmp' do
          ruby_major   = fetch(:ruby_version).scan(/^\d+\.\d+/).first
          ruby_version = "ruby-#{fetch :ruby_version}"

          execute :wget, %W{ --quiet http://cache.ruby-lang.org/pub/ruby/#{ruby_major}/#{ruby_version}.tar.gz }
          execute :tar,  'xf', "#{ruby_version}.tar.gz"

          # building and installing it
          within ruby_version do
            execute './configure'
            execute :make
            execute :make, 'install'
          end

          # updating rubygems
          execute "gem update --system" # Using string to run literal command (without prefixing)

          # removing temporary files
          execute :rm, '-rf', ruby_version, "#{ruby_version}.tar.gz"

          info "#{ruby_version.capitalize} installed successfuly"
        end
      end
    end
  end
  after "recipes:install", "ruby:install"

end
