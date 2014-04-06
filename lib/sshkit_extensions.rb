module SSHKit
  module CommandHelper
    def aptitude(*tasks)
      execute 'apt-get', tasks.flatten
    end

    def service(*tasks)
      execute :service, tasks.flatten
    end
  end
end
