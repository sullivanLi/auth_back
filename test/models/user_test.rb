require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "name should not be nil" do
    assert_same false, @user.update(name: nil)
  end

  test "password_digest should not be nil" do
    assert_same false, @user.update(password_digest: nil)
  end

  test "name should be unique" do
    user = User.create(name: @user.name)
    error_msg = user.errors.messages.fetch(:name)
    assert_includes error_msg, "has already been taken"
  end
end
