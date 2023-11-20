require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  # let(:attender) { User.create(name: "demo5", email: "demo55@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:1) }
  # let(:organizer) { User.create(name: "sample5", email: "sample55@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0) }
  # let(:event) { Event.create(title: "Sample event", description: "A event description") }
  let(:user) { User.create(name: "jen", email: "jen@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0) }

  describe "UsersController#index" do
    it "renders the attender_dashboard template" do
      sign_in(user)
      get :index
      expect(response).to have_http_status(:ok)
    end
  end  

  describe "UsersController#show" do
    it "renders the show template" do
      get :show, params: { id: user.id }
      expect(response).to have_http_status("200")
    end
  end


    
    describe "UsersController#create" do
     context "user can be created" do
      it "create the user" do
        post :create, params: {name: "Rakesh", email: "rakesh@example.com", password: "zzzzzz", password_confirmation: "zzzzzz"} 
        expect(response).to have_http_status(:success)
      end
      it "renders the index template" do
          post :create
          expect(response).to have_http_status(422)
      end
     end
    end


    describe "UsersController#login" do
     context "user can login" do
          it "login with fields" do
            User.create(email: "user@gmail.com", password: "zzzzzz")
              post :login, params:{email: user.email, password: user.password}
              expect(response).to have_http_status(200)
          end
          it "login without fields" do
            post :login
            expect(response).to have_http_status(401)
          end
     end
    end
  

    describe "UsersController#update" do
      context "User can update user" do
        it "renders the update template" do
          sign_in(user)
          patch  :update, params: {id: user.id, user: { name: "User", email: "user@gmail.com", password: "zzzzzz",password_confirmation:"zzzzzz", role:"" }}
          expect(response).to have_http_status("200")
        end
        # it "renders the index template" do
        #   sign_in(user)
        #   patch  :update, params: {name: "jay"}
        #   expect(response).to have_http_status(:unprocessable_entity)
        # end
      end
    end
    # describe UsersController do
    #   describe "#update" do
    #     let(:user) { create(:user) } # Assuming you have a FactoryBot factory for User
    
    #     context "with valid parameters" do
    #       it "updates the user and renders json" do
    #         put :update, params: { id: user.id, user: { name: "New Name" } }
    #         expect(response).to have_http_status(:ok)
    #         expect(response.content_type).to eq("application/json")
    #         parsed_response = JSON.parse(response.body)
    #         expect(parsed_response["name"]).to eq("New Name")
    #       end
    #     end
    #     context "with invalid parameters" do
    #       it "renders json with errors and returns unprocessable_entity status" do
    #         put :update, params: { id: user.id, user: { name: "" } }
    #         expect(response).to have_http_status(:unprocessable_entity)
    #         expect(response.content_type).to eq("application/json")
    #         parsed_response = JSON.parse(response.body)
    #         expect(parsed_response).to have_key("errors")
    #       end
    #     end
    #     context "when user is not found" do
    #       it "returns not_found status" do
    #         put :update, params: { id: user.id, user: { name: "New Name" } }
    #         expect(response).to have_http_status(:not_found)
    #       end
    #     end
    #   end
    # end
    



    describe "UsersController#destroy" do
      context "User can destroy" do
        it "renders the show template" do
          sign_in(user)
          delete :destroy, params: { id: user.id }
          expect(response).to have_http_status("303")
        end
      end
    end

  
end