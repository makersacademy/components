# Bring in the Singularity Grid
require 'singularitygs'

require 'middleman-livereload'

# Bring in the helpers
require 'makers_styles/helpers'

activate :directory_indexes
set :partials_dir, 'components'

set :relative_links, true

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
page "html-structure.html", :layout => :null

# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

helpers MakersStyles::Helpers

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
 configure :development do
   activate :livereload
 end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'sass'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
   #For example, change the Compass output style for deployment
   activate :minify_css

   #Minify Javascript on build
   activate :minify_javascript

   #Enable cache buster
   activate :asset_hash

   #Use relative URLs
   activate :relative_assets
end
