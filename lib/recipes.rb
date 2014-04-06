namespace :recipes do
  desc "List all known recipes"
  task :list do
    raise 'Not implemented'
  end

  desc "Install selected recipes on remote server"
  task :install do
    needs_implementation
  end

  desc "Setup selected recipes on remote server"
  task :setup do
    needs_implementation
  end
end

def needs_implementation
  puts "Needs to be implemented +_+"
end
