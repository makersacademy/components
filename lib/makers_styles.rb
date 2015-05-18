require "makers_styles/version"

module MakersStyles

  PARTIALS_DIR = 'source/components'

  def self.root
    File.join(File.dirname(__dir__))
  end

  def self.partials_dir
    File.join(root, PARTIALS_DIR)
  end
end
