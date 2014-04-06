require 'recipes'

namespace :nginx do

  desc "Install the latest stable release of nginx"
  task :install do
    on roles(:web) do
      as :root do
        aptitude %w{install -y nginx}
        execute 'update-rc.d', %w{nginx defaults}
      end
    end
  end
  after "recipes:install", "nginx:install"

  desc "Setup nginx configuration for this application"
  task :setup do
    sites_available = "/etc/nginx/sites-available/#{fetch(:application)}"
    sites_enabled   = "/etc/nginx/sites-enabled/#{fetch(:application)}"
    temp_file       = "#{fetch :tmp_dir}/#{fetch :application}"

    on roles(:web) do
      as :root do
        erb = File.read(File.expand_path("../../templates/nginx_unicorn.erb", __FILE__))
        upload! StringIO.new(ERB.new(erb).result), temp_file
        execute :chown, 'root:', temp_file
        execute :mv, temp_file, sites_available

        # link creation from sites-available ~> sites-enabled
        if test("[ -f #{sites_enabled} ]")
          execute :rm, sites_enabled
        end
        execute :ln, '--symbolic', sites_available, sites_enabled

        info "Generated nginx site configuration at /etc/nginx/sites-available/#{fetch(:application)}"
      end
    end
  end
  after "recipes:setup", "nginx:setup"

  %w{start stop restart}.each do |command|
    desc "#{command.capitalize} nginx"
    task command do
      on roles(:web) do
        as :root do
          service 'nginx', command
        end
      end
    end
  end

end
