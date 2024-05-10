require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
  test "get new user form and create a new user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: 'BigKev', email: 'bigkev@nowhere.com', password: 'abadpassword' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "BigKev", response.body
  end
  test "redirect to signup if posting incorrect values" do
    get "/signup"
    assert_difference 'User.count', 0 do
      post users_path, params: { user: { username: 'SmolKev', password: 'abadbadpassword' } }
      assert_response :success
    end
    assert_match "Sign up for alfa blog", response.body
  end
end
