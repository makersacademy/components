module ComponentClassesHelper
  def component_classes parent=nil, component="", modifiers=[]
    modifier_classes = construct_modifier_classes component, modifiers
    block_classes = construct_block_classes parent, component
    combine_classes modifier_classes, block_classes
  end

  private

  def construct_modifier_classes component, modifiers
    modifiers.inject("#{component}") { | str, mod | str << " #{component}--#{mod}" }
  end

  def construct_block_classes parent, component
    parent ? "#{parent}__#{component}" : ""
  end

  def combine_classes modifier_classes, block_classes
    "#{modifier_classes} #{block_classes}".rstrip
  end
end
