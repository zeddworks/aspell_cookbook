#
# Cookbook Name:: aspell
# Recipe:: default
#
# Copyright 2011, ZeddWorks
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

package "aspell-dev" do
  package_name value_for_platform(
    ["ubuntu", "debian"] => { "default" => "libaspell-dev" },
    ["redhat"] => { "default" => "aspell-devel" }
  )
end

ruby_block "dict_dir" do
  block do
    require 'open3'
    dict_dir = Open3.popen3("aspell config dict-dir")[1].read.chomp
    cookbook_file = Chef::Resource::CookbookFile.new("#{dict_dir}/ap.multi",@run_context)
    cookbook_file.cookbook "aspell"
    cookbook_file.source "ap.multi"
    cookbook_file.mode "0755"
    cookbook_file.run_action :create_if_missing
  end
end
