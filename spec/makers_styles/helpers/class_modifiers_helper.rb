require 'makers_styles/helpers/component_modifiers_helper'

class ComponentModifiersHelperWrapper
  include ComponentModifiersHelper
end

describe ComponentModifiersHelperWrapper do
  it "constructs components with provided modifiers" do
    component = "cta"
    modifiers = ["mod-1", "mod-2"]
    expect(subject.component_modifiers(component, modifiers)).to eq "cta cta--mod-1 cta--mod-2"
  end
end