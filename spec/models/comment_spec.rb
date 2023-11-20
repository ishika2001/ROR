require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is not valid without a description" do
    comment = Comment.create(description: "A event description")
    expect(comment).to_not be_valid
  end

  describe ".ransackable_attributes" do
    it "returns the list of allowed attributes for Ransack" do
      attributes = Comment.ransackable_attributes
      expected_attributes = ["attender_id", "created_at", "description", "event_id", "id", "updated_at"]

      expect(attributes).to match_array(expected_attributes)
    end
  end
end
