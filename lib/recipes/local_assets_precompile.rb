Rake::Task["deploy:compile_assets"].clear

namespace :deploy do
  desc "Will compile assets on local machine and then push it to remote"
  task :compile_assets do
    invoke "deploy:assets:compile_local"
  end

  desc "Compile all assets locally"
  task :compile_local do
    invoke "deploy:assets:compile_local"
  end

  namespace :assets do
    task :precompile do
      on roles(:web) do
        invoke "deploy:assets:compile_local"
      end
    end

    desc "Compile all assets locally"
    task :compile_local do
      run_locally do
        with rails_env: :production do
          execute :rm, "-rf", "public/assets/*"
          rake "assets:precompile"

          within "public/" do
            execute :tar, "cjf", "assets.tar.bz2", "assets/*"
          end
        end
      end

      on roles(:web) do
        within "#{shared_path}/public" do
          execute :rm, "-rf", "assets/*"
          upload! "public/assets.tar.bz2", "#{shared_path}/public", quiet: true
          execute :tar, "xf", "assets.tar.bz2"
          execute :rm, "assets.tar.bz2"
        end
      end

      run_locally do
        execute :rm, "public/assets.tar.bz2"
      end
    end
  end
end
