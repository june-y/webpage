# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

require 'tzinfo'
Time.zone = 'US/Eastern'

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

configure :development do
  activate :livereload
end

activate :blog do |blog|
    blog.prefix = "blog"
    blog.tag_template = "tag.html"
    blog.taglink = "{tag}.html"
    blog.calendar_template = "calendar.html"
    blog.sources = "{year}/{month}/{day}-{title}.html"
    blog.permalink = "{year}/{month}/{day}-{title}.html"
    blog.layout = "article_layout"
    # Enable pagination
    blog.paginate = true
    blog.page_link = "{num}"
    blog.per_page = 10
    blog.new_article_template = File.expand_path('../source/template.yml', __FILE__)
end

page "/blog/", :layout => "article_layout"
page "/blog/*", :layout => "article_layout"

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :partials_dir, 'partials'
set :fonts_dir, 'fonts'

activate :directory_indexes

# disable layout
page ".htaccess.apache", :layout => false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

 configure :build do
   activate :minify_css
   activate :minify_javascript
   # Append a hash to asset urls (make sure to use the url helpers)
   activate :asset_hash

   activate :asset_host, :host => 'www.juneyolcuepa.io'

 end

 activate :deploy do |deploy|
  deploy.method = :sftp
  deploy.build_before  = true
  deploy.host          = 'www.juneyolcuepa.io'
  deploy.path          = '/home/june/projects/side/personal_website'
  # Optional Settings
  # deploy.user  = 'tvaughan' # no default
  deploy.port  = 22 # ssh port, default: 22
  # deploy.clean = true # remove orphaned files on remote host, default: false
  # deploy.flags = '-rltgoDvzO --no-p --del' # add custom flags, default: -avz
end

# rename file after build
after_build do
  File.rename 'build/.htaccess.apache', 'build/.htaccess'
end
