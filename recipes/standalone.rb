

bash "install_mesos_standalone" do
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
    DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
    CODENAME=$(lsb_release -cs)
    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" |  sudo tee /etc/apt/sources.list.d/mesosphere.list
    sudo apt-get -y update
    touch #{Chef::Config[:file_cache_path]}/mesos.lock
  EOH
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/mesos.lock")}
end

package "mesos" do
  action :install
end
package "marathon" do
  action :install
end
package "chronos" do
  action :install
end