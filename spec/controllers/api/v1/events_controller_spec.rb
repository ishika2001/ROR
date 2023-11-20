# spec/controllers/api/v1/events_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  let(:user) { User.create(name: "jen", email: "jen@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0) }
  let(:event) { Event.create(title: "Updated Event Title", description: "A event description", organizer_id: user.id) }
  let(:token) { AuthenticationTokenService.encode_token(user.id) }

  before do
    sign_in(user)
  end


  describe "GET #index" do
  it "returns a JSON response with all events" do
    request.headers['Authorization'] = "Bearer #{token}"
    get :index
    expect(response).to have_http_status(:ok)
    # expect(response.content_type).to match(/application\/json/)
    # expect(JSON.parse(response.body)).to_not be_empty
  end
end

  describe "GET #show" do
    it "returns a JSON response with the specified event" do
      request.headers['Authorization'] = "Bearer #{token}"
      get :show, params: { id: event.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to match(/application\/json/)
      expect(JSON.parse(response.body)["id"]).to eq(event.id)
    end
  end

  describe "EventsController#create" do
  context "event can be created" do
   it "create the event" do
     request.headers['Authorization'] = "Bearer #{token}"
     post :create, params: {title: "birthday", venue:"indore", description:"happy!"} 
     expect(response).to have_http_status(:success)
     expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
     expect(ActionMailer::Base.deliveries.last.subject).to eq("Welcome to the event management platform!")
   end
  end
 end

  describe "PATCH #update" do
  let(:new_event_params) { { title: "Updated Event Title" } }
  let(:invalid_event_params) { { title: "" } }

  it "updates the event and returns a JSON response" do
    request.headers['Authorization'] = "Bearer #{token}"
    patch :update, params: { id: event.id, event: new_event_params }
    expect(response).to have_http_status(:ok)
    expect(response.content_type).to match(/application\/json/)
    expect(JSON.parse(response.body)["title"]).to eq("Updated Event Title")
    event.reload
    expect(event.title).to eq("Updated Event Title")
  end

  it "does not update the event in the database" do
    expect {
      request.headers['Authorization'] = "Bearer #{token}"
      patch :update, params: { id: event.id, event: invalid_event_params }
    }.not_to change { event.reload.title }
  end
end

  describe "DELETE#destroy" do
  context "User can destroy" do
    it "renders the show template" do
      request.headers['Authorization'] = "Bearer #{token}"
      delete :destroy, params: { id: event.id }
      expect(response).to have_http_status("303")
    end
  end
end


end
