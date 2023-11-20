FactoryBot.define do 
  factory :user do 
    sequence(:email) {|n| "t-#{n.to_s.rjust(3,"0")}@gmail.com"}  
    password{"123456"}
    name{"sample"}
  end
end