require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { User.create(name: "sample4", email: "sample44@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0) }
  let(:organizer) { User.create(name: "sample4", email: "sample44@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0) }
  let(:event) { Event.create(title: "Sample event", description: "A event description", organizer_id: organizer.id) } 


  describe "EventsController#show" do
    it "renders the events show template" do
      get :show, params: { id: event.id }
      expect(response).to render_template("show")
    end
  end


  describe "EventsController#create" do
    context "User can add event to event" do
      it "renders the show template" do
        sign_in(organizer)
        post  :create, params: { event: { title: "New event", description: "Description", organizer_id: organizer.id } }
        expect(response).to have_http_status("302")
        expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
        expect(ActionMailer::Base.deliveries.last.subject).to eq("Welcome to the event management platform!")
      end
    end
  end


  describe "GET #new" do
    it "assigns a new Event to @event" do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  
  describe "EventsController#update" do
    context "User can update event" do
      it "renders the update template" do
        sign_in(organizer)
        patch  :update, params: {id: event.id, event: { title: "New event", description: "Description", organizer_id: organizer.id }}
        expect(response).to have_http_status("302")
      end
    end
  end

  describe "EventsController#edit" do
    context "User can edit event" do
      it "renders the edit template" do
        sign_in(organizer)
        patch  :edit, params: {id: event.id, event: { title: "New event", description: "Description", organizer_id: organizer.id }}
        expect(response).to have_http_status("200")
      end
    end
  end



  describe "EventsController#destroy" do
    context "User can destroy event" do
      it "renders the show template" do
        sign_in(organizer)
        delete :destroy, params: { id: event.id }
        expect(response).to have_http_status("303")
      end
    end
  end

end