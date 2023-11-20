# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  enum role: [:organizer, :attender]
  has_many :events, class_name: 'Event', foreign_key: 'organizer_id', dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: 'attender_id', dependent: :destroy
  has_many :tickets, class_name: 'Ticket'
  has_and_belongs_to_many :attended_events, class_name: 'Event', dependent: :destroy
  validates :name, presence: true
  after_create :after_create_mail
  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def set_default_role
    self.role ||= :user
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at"]
  end

  
  private

  def after_create_mail
    CrudNotificatonMailer.welcome(self).deliver_now
  end
end

