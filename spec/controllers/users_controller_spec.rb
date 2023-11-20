require 'rails_helper'

# RSpec.describe UsersController, type: :controller do
#   let(:attender) { User.create(name: "demo", email: "demo11@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:1) }
#   let(:organizer) { User.create(name: "sample", email: "sample11@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0) }
#   let(:event) { Event.create(title: "Sample event", description: "A event description") }
#   let(:user) { User.create(name: "tom", email: "tom1@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0) }

  RSpec.describe UsersController, type: :controller do
    # describe "GET #index" do
    #   it "assigns @users with users having role 0" do
    #     user_with_role_0 = User.create(role: 0)
    #     user_with_role_1 = User.create(role: 1)
  
    #     get :index
  
    #     expect(assigns(:users)).to include(user_with_role_0)
    #     expect(assigns(:users)).not_to include(user_with_role_1)
    #   end
  
    #   it "assigns a Ransack search object to @q" do
    #     get :index
  
    #     expect(assigns(:q)).to be_a(Ransack::Search)
    #   end
  
    #   it "assigns the result of the Ransack search to @users" do
    #     user_with_role_0 = User.create(role: 0)
    #     user_with_role_1 = User.create(role: 1)
  
    #     get :index, params: { q: { role_eq: 0 } }
  
    #     expect(assigns(:users)).to include(user_with_role_0)
    #     expect(assigns(:users)).not_to include(user_with_role_1)
    #   end
  
    #   it "renders the index template" do
    #     get :index
  
    #     expect(response).to have_http_status("200")
    #   end
    # end
  end
# end
