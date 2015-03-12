version = '2.5.0'
bash "install_pypy" do
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    wget https://bitbucket.org/pypy/pypy/downloads/pypy-#{version}-linux64.tar.bz2
    tar jxf pypy-#{version}-linux64.tar.bz2
    mv pypy-#{version}-linux64 /opt/
    
    
    cd /opt/pypy-#{version}-linux64/site-packages/
    wget http://nightly.ziade.org/distribute_setup.py
    /opt/pypy-#{version}-linux64/bin/pypy distribute_setup.py
    
    cd /opt/pypy-#{version}-linux64/bin
    curl -O https://bootstrap.pypa.io/get-pip.py
    /opt/pypy-#{version}-linux64/bin/pypy get-pip.py
    rm get-pip.py
    #ln -s /opt/#{version}/bin/pypy /usr/bin/pypy
  EOH
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/pypy-#{version}-linux64.tar.bz2")}
end

link "/usr/bin/pypy" do
      to "/opt/pypy-#{version}-linux64/bin/pypy"
end


=begin
bash "install_pypy_bs4" do
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    /opt/pypy-#{version}-linux64/bin/easy_install beautifulsoup4
    touch #{Chef::Config[:file_cache_path]}/pypy_bs4.lock
  EOH
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/pypy_bs4.lock")}
end
=end






