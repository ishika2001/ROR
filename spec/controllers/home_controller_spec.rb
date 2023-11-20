require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:attender) { User.create(name: "demo3", email: "demo33@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:1) }
  let(:organizer) { User.create(name: "sample3", email: "sample33@gmail.com",password: "zzzzzz", password_confirmation:"zzzzzz", role:0) }
  let(:event) { Event.create(title: "Sample event", description: "A event description", organizer_id: organizer.id) }

  describe "GET #index" do
    it "renders the index template" do
      sign_in(attender)
      get :index
      expect(response).to have_http_status("200")
    end
    it "renders the index template" do
      sign_in(organizer)
      get :index
      expect(response).to have_http_status("200")
    end
  end

end