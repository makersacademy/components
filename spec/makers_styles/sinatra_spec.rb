require "makers_styles/sinatra"

module Sinatra
  describe Makers do

    let(:app) { TestSinatra }

    it "adds the partial directory to the views directory" do
      expect(app.views).to eq(["views", MakersStyles.partials_dir])
    end

    it "sets up the asset pipeline to work with the makers style gem" do
      expect(app).to respond_to(:sprockets)
    end

    it "includes all the makers helpers" do
      expect(app.ancestors).to include(MakersStyles::Helpers)
    end

    it "includes the sinatra partial helper" do
      expect(app.ancestors).to include(Sinatra::Partial)
    end
  end
end

class TestSinatra < Sinatra::Base
  register Sinatra::Makers
end
