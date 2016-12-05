require 'test_helper'

class Api::GreetingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "get greetings" do
    get "/api/greetings", headers: { Authorization: "Token token=#{@user.token}" }

    json = JSON.parse(@response.body)
    assert_response 200
    assert_equal json['message'], "Hello, #{@user.name}"
  end

  test "unauthorized action" do
    get "/api/greetings"

    json = JSON.parse(@response.body)
    assert_response 401
    assert_equal json['error'], "bad credentials"
  end
end
