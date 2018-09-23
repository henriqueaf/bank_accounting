module SpecHelpers
  module ControllerMacros
    def sign_in_before(user = build_stubbed(:user))
      before do
        sign_in_mock_user(user)
      end
    end

    def expect_redirected_after
      after do
        expect_redirect
      end
    end
  end
end
