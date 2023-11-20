# frozen_string_literal: true

# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :attender, class_name: 'User'
  validates :description, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["attender_id", "created_at", "description", "event_id", "id", "updated_at"]
  end
end
