Refinery::Plugin.register do |plugin|
  plugin.title = "Tutorials"
  plugin.name = "tutorials"
  plugin.description = "Manage Tutorials"
  plugin.version = 1.0
  plugin.activity = {
    :class => Tutorial,
    :url_prefix => "edit",
    :title => 'title'
  }
  # this tells refinery where this plugin is located on the filesystem and helps with urls.
  plugin.directory = directory
end
