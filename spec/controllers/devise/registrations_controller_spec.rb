require 'rails_helper'

RSpec.describe Devise::RegistrationsController, type: :controller do
  let(:user){ build(:user) }

  context "signed in user" do
    describe "POST #create" do
      context "with valid attributes" do
        it "should return http success" do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          post :create, params: attributes_for(:user)

          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
