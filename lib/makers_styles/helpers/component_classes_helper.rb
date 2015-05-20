module ComponentClassesHelper
  def component_classes parent=nil, component="", modifiers=[]
    modifier_classes = modifiers.inject("#{component}") { | str, mod | str << " #{component}--#{mod}" }
    block_classes = parent ? "#{parent}__#{component}" : ""
    (modifier_classes + " " + block_classes).rstrip
  end
end
