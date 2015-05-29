require "sinatra/base"
require "sinatra/contrib"
require "sinatra/partial"
require "sinatra/asset_pipeline"
require "makers_styles"
require "makers_styles/page"
require "uglifier"
require "sass"

module Sinatra
  module Makers
    def self.registered(app)
      # Without this the asset pipeline fails in our tests
      app.set :root, "/" unless app.root

      app.helpers MakersStyles::Helpers

      app.helpers do
        # This allows us to have multiple view directories, so we can load
        # view partials from the MakersStyles gem
        def find_template(views, name, engine, &block)
          Array(views).each { |v| super(v, name, engine, &block) }
        end
      end

      app.set :assets_precompile, %w(application.js application.css *.png *.jpg *.eot *.ttf *.woff *.woff2)
      app.set :assets_js_compressor, :uglifier
      app.set :assets_css_compressor, :sass

      app.set(:views, ["views", MakersStyles.partials_dir])

      app.register Sinatra::AssetPipeline
      app.register Sinatra::Partial

      %w(stylesheets javascripts).each do |folder|
        app.settings.sprockets.append_path(File.join(MakersStyles.assets_dir, folder))
      end

      app.set :partial_template_engine, :erb
      app.enable :partial_underscores
    end
  end

  register Makers
end
