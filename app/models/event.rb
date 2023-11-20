# frozen_string_literal: true

# app/models/event.rb
class Event < ApplicationRecord
  belongs_to :organizer, class_name: 'User', foreign_key: 'organizer_id'
  has_and_belongs_to_many :attenders, class_name: 'User', dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, :description, presence: true

  # accepts_nested_attributes_for :tickets

  # def self.ransackable_attributes(auth_object = nil)
  #   %w(title)
  # end

  def self.ransackable_associations(auth_object = nil)
    ["attenders", "comments", "organizer", "tickets"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "description", "id", "image", "organizer_id", "time", "title", "updated_at", "venue"]
  end
end
