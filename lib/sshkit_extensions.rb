module SSHKit
  module CommandHelper
    def aptitude(tasks=[])
      execute 'apt-get', tasks

    def service(*tasks)
      execute :service, tasks.flatten
    end
  end
end
