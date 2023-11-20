# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name and an email" do
    user = User.new(name: "nia", email: "nia1@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz")
    expect(user).to be_valid
  end

   it "is not valid without a name" do
    user = User.new(email: "nia1@gmail.com")
    expect(user).to_not be_valid
  end

  it "is not valid without an email" do
    user = User.new(name: "nia")
    expect(user).to_not be_valid
  end

  it "has many events" do
    user = User.reflect_on_association(:events)
    expect(user.macro).to eq(:has_many)
  end

  
  
end