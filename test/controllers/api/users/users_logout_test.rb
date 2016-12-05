require 'test_helper'

class Api::UsersLogoutTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "logout successful" do
    post "/api/users/logout", headers: { Authorization: "Token token=#{@user.token}" } 

    @user.reload
    json = JSON.parse(@response.body)
    assert_response 200
    assert_equal json['message'], "logout successful"
    assert_nil @user.token
  end

  test "logout without token" do
    post "/api/users/logout"

    json = JSON.parse(@response.body)
    assert_response 400
    assert_equal json['error'], "invalid token"
  end
end
