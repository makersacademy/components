require "makers_styles/version"
require "makers_styles/helpers"

module MakersStyles

  PARTIALS_DIR = 'source/components'
  ASSETS_DIR = 'source'

  def self.root
    File.join(File.dirname(__dir__))
  end

  def self.partials_dir
    File.join(root, PARTIALS_DIR)
  end

  def self.assets_dir
    File.join(root, ASSETS_DIR)
  end
end
