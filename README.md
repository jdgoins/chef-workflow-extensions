# chef-workflow-extensions

Chef Workflow Extensions is a library cookbook that includes a collection of custom
resources that make creating build cookbooks for Chef Workflow projects a delightful
experience. It is inspired by the work done on delivery-sugar and delivery-truck

## Installation

If you are using Berkshelf, add `chef-workflow-extensions` to your `Berksfile`:

    cookbook 'chef-workflow-extensions', github: 'johnbyrneio/chef-workflow-extensions'

## Usage

In order to use Chef Workflow Extensions in your build cookbook recipes, you'll
first need to declare your dependency on it in your metadata.rb.

    depends 'chef-workflow-extensions'

Declaring your dependency will automatically make available the custom resources
included with Chef Workflow Extensions.

## Resources

### ext_cookbook_upload

If you use delivery-truck, it only uploads cookbooks to Chef Automate's Chef org.
This resource can be used to upload cookbooks to addition Chef Servers/Orgs:

```ruby
ext_cookbook_upload 'Acme Production Chef Server' do
  knife_rb_path '/var/opt/delivery/workspace/.chef/acme-prod-knife.rb'
end
```

You will need to ensure that you have deployed a knife.rb and user.pem to your
job runners prior to using this resource.
