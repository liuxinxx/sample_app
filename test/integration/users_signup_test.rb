require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
          user:{name: "",
          email:"user@invalid",
          password:" ",
          password_confirmation: "bor"}
      }
    end
    assert_template 'users/new'
    # assert_select 'div#<CSS id for error explanation>'
    # assert_select 'div.<CSS class for field with error>'
    # assert_select 'div#<CSS id for error explanation>'
    # assert_select 'div.<CSS class for field with error>'
   end
end
