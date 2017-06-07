resource_name :ext_cookbook_upload

property :knife_rb_path, String

action :upload do
  # Create the upload directory where cookbooks to be uploaded will be staged
  cookbook_directory = ::File.join(node['delivery']['workspace']['cache'], "cookbook-upload")
  directory cookbook_directory do
    recursive true
    # We delete the cookbook upload staging directory each time to ensure we
    # don't have out-of-date cookbooks hanging around from a previous build.
    action [:delete, :create]
  end

  changed_cookbooks.each do |cookbook|
    if ::File.exist?(::File.join(cookbook.path, 'Berksfile'))
      execute "berks_vendor_cookbook_#{cookbook.name}" do
        command "berks vendor #{cookbook_directory}"
        cwd cookbook.path
      end
    else
      link ::File.join(cookbook_directory, cookbook.name) do
        to cookbook.path
      end
    end

    execute "upload_cookbook_#{cookbook.name}" do
      command "knife cookbook upload #{cookbook.name} --freeze --all --force " \
              "--config #{knife_rb_path} " \
              "--cookbook-path #{cookbook_directory}"
    end
  end
end
