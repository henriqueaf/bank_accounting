module SpecHelpers
  module ControllerHelpers
    def sign_in_mock_user(user = build_stubbed(:user))
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    def expect_redirect
      expect(response).to have_http_status(:redirect)
    end
  end
end
