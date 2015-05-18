module ComponentModifiersHelper
  def component_modifiers component, modifiers
    modifiers.inject("#{component}") { | str, mod | str << " cta--#{mod}" }
  end
end
