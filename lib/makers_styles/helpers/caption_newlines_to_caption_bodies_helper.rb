module CaptionNewlinesToCaptionBodiesHelper
  def newlines_to_caption_bodies caption
    caption.split("\n").map { | line | { text: line } }
  end
end
