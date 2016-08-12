#
# Cookbook Name:: data-bag-faker
# Recipe:: default
#

Chef::Log.warn('***************** Stubbing a data bag item with environment variables')

# Load the data bag item file from disk.
data_bag_item_path = "#{Chef::Config[:data_bag_path]}/#{node['data-bag-faker']['target_data_bag']}/#{node['data-bag-faker']['target_data_bag_item']}.json"
edit_file = Chef::Util::FileEdit.new(data_bag_item_path)

node['data-bag-faker']['variables'].each do |key, value|
  edit_file.search_file_replace("<@#{key}@>", value)
end

# Write all changes to the data bag item file.
edit_file.write_file

# Delete the backup file that was created by FileEdit.
::File.delete("#{data_bag_item_path}.old")
