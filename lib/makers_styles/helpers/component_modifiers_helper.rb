module ComponentModifiersHelper
  def component_modifiers component, modifiers
    modifiers.inject("#{component}") { | str, mod | str << " #{component}--#{mod}" }
  end
end
