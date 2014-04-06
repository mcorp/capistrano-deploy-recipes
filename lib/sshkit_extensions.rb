module SSHKit
  module CommandHelper
    def aptitude(tasks=[])
      execute 'apt-get', tasks
    end
  end
end
