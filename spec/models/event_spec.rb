require 'rails_helper'

RSpec.describe Event, type: :model do
  it "is valid with a title and a description" do
    user= User.create(name: "kia", email: "kia1@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0)
    event = Event.new(title: "birthday", description: "Abab", organizer_id:user.id)
    expect(event).to be_valid
  end

  it "is not valid without a title" do
    event = Event.new(description: "A event description")
    expect(event).to_not be_valid
  end

  it "is not valid without a description" do
    event = Event.new(title: "Sample event")
    expect(event).to_not be_valid
  end

  it "has many tickets" do
    event = Event.reflect_on_association(:tickets)
    expect(event.macro).to eq(:has_many)
  end

  describe ".ransackable_associations" do
    it "returns the list of allowed associations for Ransack" do
      associations = Event.ransackable_associations
      expected_associations = ["attenders", "comments", "organizer", "tickets"]

      expect(associations).to match_array(expected_associations)
    end
  end

  describe ".ransackable_attributes" do
    it "returns the list of allowed attributes for Ransack" do
      attributes = Event.ransackable_attributes
      expected_attributes = ["created_at", "date", "description", "id", "image", "organizer_id", "time", "title", "updated_at", "venue"]

      expect(attributes).to match_array(expected_attributes)
    end
  end
  # it "belongs to a user" do
  #   event = Event.reflect_on_association(:user)
  #   expect(event.macro).to eq(:belongs_to)
  # end
end