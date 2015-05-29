require "hashie/mash"
require "pathname"
require "yaml"
require "makers_styles/template"

module MakersStyles

  class Page

    DIRECTORY = "content/pages"
    LAYOUT_FILE = "content/layout.yml"

    def initialize(content, layout)
      @content = content
      @layout = layout
    end

    def title
      content["title"] || raise("Please enter a title for the page")
    end

    def description
      content["description"] || raise("Please enter a description for the <meta> description tag")
    end

    def templates
      content["templates"].map do |template_content|
        Template.new(template_content)
      end
    end

    def nav_template_name
      nav_template.name
    end

    def nav_template
      Template.new(layout["nav_template"])
    end

    def footer_template_name
      footer_template.name
    end

    def footer_template
      Template.new(layout["footer_template"])
    end

    def self.find(page)
      page_content = config_path(page)
      return unless page_content.exist?
      new(load(page_content), load(LAYOUT_FILE))
    end

    private

    attr_reader :layout, :content

    def self.load(file)
      YAML.load_file(file)
    end

    def self.config_path(page)
      # We have to remove the leading slash from the page name or Pathname gets
      # confused
      Pathname.new(DIRECTORY) + "#{page}.yml".sub(/^\//, "")
    end
  end
end
