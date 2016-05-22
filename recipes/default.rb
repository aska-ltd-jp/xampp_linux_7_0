#
# Cookbook Name:: xampp_linux_7_0
# Recipe:: default
#
# Copyright 2016, Aska Co., Ltd. http://www.aska-ltd.jp/
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

remote_uri_base = node["xampp_linux_7_0"]["remote_uri_base"]

x64_str = node["xampp_linux_7_0"]["x64_str"]

if node["xampp_linux_7_0"]["x64_str"] == "x64"
  x64_str = "-#{node["xampp_linux_7_0"]["x64_str"]}"
end

major_version = node["xampp_linux_7_0"]["major_version"]
minor_version = node["xampp_linux_7_0"]["minor_version"]
build_number = node["xampp_linux_7_0"]["build_number"]

version = "#{major_version}.#{minor_version}.#{build_number}"

release_number = node["xampp_linux_7_0"]["release_number"]

xampp_installer = "xampp-linux#{x64_str}-#{version}-#{release_number}-installer.run"
xampp_installer_path = "#{Chef::Config[:file_cache_path]}/#{xampp_installer}"

remote_uri = "#{remote_uri_base}#{version}/#{xampp_installer}"

command_path = node["xampp_linux_7_0"]["command_path"]
file_sha256sum = node["xampp_linux_7_0"]["file_sha256sum"]

cookbook_file xampp_installer_path do
  ignore_failure true
  action :create_if_missing
  not_if { File.exists? command_path }
  source xampp_installer
  mode 0644
end

remote_file xampp_installer_path do
  action :create_if_missing
  not_if { File.exists? command_path }
  source remote_uri
  checksum file_sha256sum
end

bash "install_xampp_linux" do
  only_if { File.exists? xampp_installer_path }
  not_if { File.exists? command_path }
  cwd Chef::Config[:file_cache_path]
  code <<-EOC
    sudo chmod +x #{xampp_installer}
    sudo ./#{xampp_installer}
  EOC
end

bash "link_lampp_command" do
  only_if { File.exists? command_path }
  not_if { File.exists? "/etc/init.d/lampp" }
  code <<-EOC
    sudo ln -s /opt/lampp/lampp /etc/init.d/lampp
  EOC
end

service "lampp" do
  start_command "#{command_path} startapache"
  stop_command "#{command_path} stopapache"
  reload_command "#{command_path} reloadapache"
  supports :reload => true, :status => true
  action [:enable, :reload]
end

file xampp_installer_path do
  only_if { File.exists? xampp_installer_path }
  action :delete
end
