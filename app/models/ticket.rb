# frozen_string_literal: true

# app/models/ticket.rb
class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates :name, :price, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["attender_id", "created_at", "event_id", "id", "name", "price", "status", "updated_at", "user_id"]
  end
end
