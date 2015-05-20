require 'makers_styles/helpers/caption_newlines_to_caption_bodies_helper'

class CaptionNewlinesToCaptionBodiesHelperWrapper
  include CaptionNewlinesToCaptionBodiesHelper
end

describe CaptionNewlinesToCaptionBodiesHelperWrapper do
  it "translates newline entities to caption body hashes correctly" do
    caption = "Lorem\nIpsum Dolor\nSit Amet Consectetur"
    expected_caption_bodies = [
      { text: "Lorem" },
      { text: "Ipsum Dolor" },
      { text: "Sit Amet Consectetur" }
    ]
    expect(subject.newlines_to_caption_bodies(caption)).to eq expected_caption_bodies
  end
end