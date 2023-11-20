require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  include Devise::Test::ControllerHelpers

  controller do
    def index
      render plain: 'ok'
    end
  end

  describe "#configure_permitted_parameters" do
    before do
      allow(controller).to receive(:devise_controller?).and_return(true)
    end

    it "permits specific parameters for sign-up and account update" do
      expect(controller).to receive(:configure_permitted_parameters)
      get :index
    end
  end

  describe "configure_permitted_parameters" do
    before do
      allow_any_instance_of(ActionController::Base).to receive(:devise_parameter_sanitizer).and_return(double('sanitizer', permit: nil))
    end
    it "permits specific parameters for sign-up and account update" do
      controller.send(:configure_permitted_parameters)
      sign_up_permitted = controller.send(:devise_parameter_sanitizer).permit(:sign_up)
      account_update_permitted = controller.send(:devise_parameter_sanitizer).permit(:account_update)
      expect(sign_up_permitted).to be_nil
      expect(account_update_permitted).to be_nil
    end
  end
end
