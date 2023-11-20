require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "is valid with a name and a price" do
    user= User.create(name: "joe", email: "joe1@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0)
    event = Event.create(title: "birthday", description: "Abab", organizer_id:user.id)

    ticket = Ticket.new(name: "birthday", price: "Abab", event_id:event.id, user_id:user.id)
    expect(ticket).to be_valid
  end

  it "is not valid without a name" do
    ticket = Ticket.new(price: 2500)
    expect(ticket).to_not be_valid
  end

  it "is not valid without a price" do
    ticket = Ticket.new(name: "Sample ticket")
    expect(ticket).to_not be_valid
  end

  it "belongs to a event" do
    ticket = Ticket.reflect_on_association(:event)
    expect(ticket.macro).to eq(:belongs_to)
  end

  describe ".ransackable_attributes" do
    it "returns the list of allowed attributes for Ransack" do
      attributes = Ticket.ransackable_attributes
      expected_attributes = ["attender_id", "created_at", "event_id", "id", "name", "price", "status", "updated_at", "user_id"]

      expect(attributes).to match_array(expected_attributes)
    end
  end
end