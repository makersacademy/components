require "hashie/mash"
require "yaml"

# This class has to subclass from hashie as we need templates to
# work with Sinatra's partial helper - this requires that all keys are symbols
# but Ruby's yaml parser passes them in as strings annoyingly
module MakersStyles
  class Template < Hashie::Mash

    def self.from_file(path)
      content = YAML.load_file(path)
      new(content)
    end
  end
end
