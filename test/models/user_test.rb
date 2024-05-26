require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: 'john@example.com', password: '123456')
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without email' do
    @user.email = nil
    refute @user.valid?,  @user.errors[:email]
  end

  test 'invalid without password' do
    @user.password = nil
    refute @user.valid?, @user.errors[:password]
  end


end
