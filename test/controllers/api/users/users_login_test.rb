require 'test_helper'

class Api::UsersLoginTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(name: 'myname', password: 'myword')
  end

  test "login successful" do
    post "/api/users/login", params: { name: @user.name, password: @user.password }

    json = JSON.parse(@response.body)
    assert_response 200
    assert_equal json['message'], "login successful"
    assert_not_nil json['token']
  end

  test "login failed when password is not matched" do
    post "/api/users/login", params: { name: @user.name, password: 'hackerword' }

    json = JSON.parse(@response.body)
    assert_response 401
    assert_equal json['error'], "login failed"
  end

  test "login failed when user is existing" do
    post "/api/users/login", params: { name: 'hackername', password: 'hackerword' }

    json = JSON.parse(@response.body)
    assert_response 401
    assert_equal json['error'], "login failed"
  end
end
