require "makers_styles/template"

module MakersStyles
  describe Template do

    subject(:template) do
      described_class.new(data)
    end

    let(:data) do
      { "text" => { "primary" => "nav" } }
    end

    # Partials need all keys (even nested) to be converted to symbols so they can
    # work with Sinatra's partial helper - they are annoyingly strings when we
    # load them in from a yaml file so they have to be converted
    it "has templates that can be passed to a partial" do
      expect(subject[:text][:primary]).to eq("nav")
    end

    describe "Loading a template from file" do
      before do
        allow(YAML).to receive(:load_file).with("file.yml").and_return(data)
        allow(described_class).to receive(:new).with(data).and_return(:template)
      end

      it "parses a YAML file and creates a new template" do
        expect(described_class.from_file("file.yml")).to eq(:template)
      end
    end
  end
end
