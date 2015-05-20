require 'makers_styles/helpers/component_classes_helper'

class ComponentClassesHelperWrapper
  include ComponentClassesHelper
end

describe ComponentClassesHelperWrapper do
  it "constructs component classes" do
    locals = {
      parent: "cta-block",
      component: "cta",
      modifiers: ["mod-1", "mod-2"]
    }
    expect(subject.component_classes(locals)).to eq "cta cta--mod-1 cta--mod-2 cta-block__cta"
  end

  context "in the absence of a parent component" do
    it "constructs component classes without block-level classes" do
      locals = {
        parent: nil,
        component: "cta",
        modifiers: ["mod-1", "mod-2"]
      }
      expect(subject.component_classes(locals)).to eq "cta cta--mod-1 cta--mod-2"
    end
  end

  context "in the absence of modifiers" do
    it "constructs component classes without modifier classes" do
      locals = {
        parent: "cta-block",
        component: "cta",
        modifiers: []
      }
      expect(subject.component_classes(locals)).to eq "cta cta-block__cta"
    end
  end

  context "in the absence of both parent components and modifiers" do
    it "constructs component classes without modifier or block-level classes" do
      locals = {
        parent: nil,
        component: "cta",
        modifiers: []
      }
      expect(subject.component_classes(locals)).to eq "cta"
    end
  end
end
