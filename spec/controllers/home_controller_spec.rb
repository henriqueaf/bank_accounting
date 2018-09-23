require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context "unsigned user" do
    expect_redirected_after

    describe "GET #index" do
      it "returns http success" do
        get :index
      end
    end
  end

  context "signed in user" do
    sign_in_before

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
