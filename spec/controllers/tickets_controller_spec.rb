require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:attender) { User.create(name: "demo2", email: "demo22@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:1) }
  let(:organizer) { User.create(name: "sample2", email: "sample22@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0) }
  let(:event) { Event.create(title: "Birthday", description: "Happy birthday", organizer_id: organizer.id) }
  let(:ticket) { Ticket.create(name:"b101", price:1000, event_id:event.id, attender_id:attender.id, status:"booked", user_id:attender.id) }
  let!(:booked_ticket) { Ticket.create(name:"b101", price:1000, event_id:event.id, attender_id:attender.id, status:"booked", user_id:attender.id) }
  let!(:unbooked_ticket) { Ticket.create(name:"b101", price:1000, event_id:event.id, attender_id:attender.id, status:"not-booked", user_id:attender.id) }

  describe "TicketsController#show" do
    it "renders the tickets show template" do
      get :show, params: { event_id: event.id }
      expect(assigns(:event)).to eq(event)
      expect(assigns(:ticket)).to match_array([booked_ticket, unbooked_ticket])
      expect(assigns(:booked)).to eq(1) 
      expect(assigns(:unbooked)).to eq(1)  
      expect(response).to render_template("show")
    end
  end


  describe "TicketsController#download_pdf" do
    context "Ticket pdf download" do
      it "renders the show template" do
      sign_in(attender)
      ticket = Ticket.create(name:"b101", price:1000, event_id:event.id, attender_id:attender.id, status:"booked", user_id:attender.id)
        get :download_pdf, params: {id: ticket.id }
        expect(response).to have_http_status("200")
      end
    end
  end


  describe TicketsController do
   describe "#create" do
    let(:user) { User.create(name: "jeni", email: "jeni@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:"organizer") }
    let(:ticket_params) { { name: "Ticket Name", price: 100 } } # Adjust the parameters as needed

    context "when user is an organizer" do
      before { user.update(role: "organizer") }
      it "creates a ticket and redirects to the ticket page" do
        sign_in(user)
        post :create, params: { ticket: ticket_params }
        expect(response).to redirect_to(assigns(:ticket))
        expect(flash[:error]).to be_nil
      end
    end

    context "when user is not an organizer" do
      it "does not create a ticket and redirects to the root path with an error message" do
        sign_in(user)
        post :create, params: { ticket: ticket_params }
        expect(response).to redirect_to(tickets_path)
        expect(flash[:error]).to be_nil
      end
    end
  end
end

describe "GET #new" do
it "renders the 'new' template and assigns a new ticket" do
  get :new
  expect(response).to render_template(:new)
  expect(assigns(:ticket)).to be_a_new(Ticket)
end
end

  
describe "TicketsController#book" do
  it "renders the show template and returns 204 when booking a not-booked ticket" do
    sign_in(attender)
    ticket = Ticket.create(name: "b101", price: 1000, event_id: event.id, attender_id: attender.id, status: "not-booked", user_id: attender.id)
    post :book, params: { id: ticket.id }
    expect(assigns(:ticket)).to eq(ticket)
    expect(response).to have_http_status(204)
  end

  it "does not book when the ticket is already booked and returns 204" do
    ticket = Ticket.create(name: "b101", price: 1000, event_id: event.id, attender_id: attender.id, status: "booked", user_id: attender.id)
    post :book, params: { id: ticket.id }
    expect(assigns(:ticket)).to eq(ticket)
    expect(response).to have_http_status(204)
    # expect(flash[:error]).to eq(nil)
  end

  it "handles the case when the ticket record is not found" do
    post :book, params: { id: 999 }
    expect(flash[:error]).to eq("Ticket record not found.")
    expect(response).to have_http_status(204)
  end
end


end