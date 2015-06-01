require "makers_styles/page"

describe MakersStyles::Page do

  subject(:page) { described_class.new(page_content, layout_content) }

  let(:template_class) { class_double("MakersStyles::Template").as_stubbed_const }

  let(:page_content) do
    {
      "title" => "Welcome to the page",
      "templates" => [{"name" => "nav"}]
    }
  end

  let(:layout_file) { described_class::LAYOUT_FILE }
  let(:layout_content) do
    {
      "nav_template" => {"name" => "nav"},
      "footer_template" => [{"name" => "footer"}]
    }
  end

  it "has a title" do
    expect(subject.title).to eq("Welcome to the page")
  end

  describe "Nav template" do

    let(:nav) { double(:nav, name: "nav") }

    before do
      stub_template(layout_content["nav_template"]).and_return(nav)
    end

    it "has a nav bar template name" do
      expect(subject.nav_template_name).to eq("nav")
    end

    it "has a nav bar template name" do
      expect(subject.nav_template).to eq(nav)
    end
  end

  describe "Footer template" do

    let(:footer) { double(:footer, name: "footer") }

    before do
      stub_template(layout_content["footer_template"]).and_return(footer)
    end

    it "has a footer bar template name" do
      expect(subject.footer_template_name).to eq("footer")
    end

    it "has a footer bar template name" do
      expect(subject.footer_template).to eq(footer)
    end
  end

  it "has a footer template" do
    stub_template(layout_content["footer_template"]).and_return(:footer)
    expect(subject.footer_template).to eq(:footer)
  end

  context "when there is no title" do

    before do
      page_content["title"] = nil
    end

    it "raises a friendly error" do
      expect { subject.title }.to raise_error
    end
  end

  it "has templates that can be passed to a partial" do
    stub_template(page_content["templates"].first).and_return(:template)
    expect(subject.templates).to eq([:template])
  end

  context "when there is no description" do

    before do
      page_content["description"] = nil
    end

    it "raises a friendly error" do
      expect { subject.description }.to raise_error
    end
  end

  describe "Finding pages" do

    before do
      stub_files
      stub_initializing_page
    end

    let(:path) { double(:path, exist?: true) }

    it "finds and loads details for a page based on the url" do
      expect(described_class.find("/test")).to eq(:page)
    end

    context "when the page does not exist" do

      let(:path) { double(:path, exist?: false) }

      it "does not return a page" do
        expect(described_class.find("/non-existent")).to be nil
      end
    end

    def stub_files
      allow(described_class).to receive(:config_path).and_return(path)
      allow(YAML).to receive(:load_file).with(path).and_return(page_content)
      allow(YAML).to receive(:load_file).with(layout_file).and_return(layout_content)
    end

    def stub_initializing_page
      allow(described_class).to receive(:new).with(page_content, layout_content).and_return(:page)
    end
  end

  def stub_template(content)
    allow(template_class).to receive(:new).with(content).and_return(:template)
  end
end
