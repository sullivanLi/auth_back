require 'test_helper'

class Api::UsersCreateTest < ActionDispatch::IntegrationTest
  test "does not create user when name is empty" do
    post "/api/users/create", params: { password: 'password' }

    json = JSON.parse(@response.body)
    assert_response 400
    assert_includes json['error']['name'], "can't be blank"
  end

  test "does not create user when password is empty" do
    post "/api/users/create", params: { name: 'username' }

    json = JSON.parse(@response.body)
    assert_response 400
    assert_includes json['error']['password'], "can't be blank"
  end

  test "create a new user" do
    post "/api/users/create", params: { name: 'username', password: 'password' }

    json = JSON.parse(@response.body)
    assert_response 200
    assert_equal json['message'], "user created"
  end

  test "does not create users when user name has already been used" do
    User.create(name: 'myname', password: 'mypassword')
    post "/api/users/create", params: { name: 'myname', password: 'password' }

    json = JSON.parse(@response.body)
    assert_response 400
    assert_includes json['error']['name'], "has already been taken"
  end
end
