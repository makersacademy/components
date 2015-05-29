require "hashie/mash"

# This class has to subclass from hashie as we need templates to
# work with Sinatra's partial helper - this requires that all keys are symbols
# but Ruby's yaml parser passes them in as strings annoyingly
module MakersStyles
  class Template < Hashie::Mash; end
end
