RACK_ENV = ENV['RACK_ENV'] || 'development'

require 'bundler/setup'
require 'dotenv'

Bundler.require :default, RACK_ENV

###
# brother.ly site settings
###

Time.zone = 'EST'

ignore '/partials/*'

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
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Pretty URLs - http://middlemanapp.com/basics/pretty-urls/
activate :directory_indexes

# Meta tag helpers
activate :meta_tags
set_meta_tags \
  'fb:app_id' => ENV['FACEBOOK_APP_ID']

# Directory settings
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :partials_dir, 'partials'

# Build-specific configuration
configure :build do
  # Change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Use relative URLs
  activate :relative_assets

  # Ensure env vars are loaded
  activate :dotenv
end

# Deploy to Amazon S3
# activate :s3_sync do |s3_sync|
#   s3_sync.bucket                     = 'brother.ly'
#   s3_sync.region                     = ENV['AWS_DEFAULT_REGION']
#   s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY_ID']
#   s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_ACCESS_KEY']
#   s3_sync.delete                     = false
#   s3_sync.after_build                = false
#   s3_sync.prefer_gzip                = true
#   s3_sync.path_style                 = true
#   s3_sync.reduced_redundancy_storage = false
#   s3_sync.acl                        = 'public-read'
#   s3_sync.encryption                 = false
#   s3_sync.prefix                     = ''
#   s3_sync.version_bucket             = false
# end

Dotenv.load

# Invalidate CloudFront CDN caches when building
activate :cloudfront do |cf|
  cf.access_key_id = ENV['AWS_ACCESS_KEY_ID']
  cf.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  cf.distribution_id = ENV['AWS_CLOUDFRONT_DISTRO_ID']
  cf.after_build = ENV['CI']
end

page '/sitemap.xml', layout: false

# Page title helpers
activate :title, title: data.site.title, separator: ' | '

# Auto-prefix CSS rules
require 'autoprefixer-rails'
activate :autoprefixer
