require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Jeff", email: "jeff@gmail.com",
                    password: "foobar", password_confirmation: "foobar")
  end

  test "should be a valid user" do
    assert @user.valid?
  end

  test "blank name should not be valid" do 
    @user.name = "  "
    assert_not @user.valid?
  end

  test "name over 50 characters should be invalid" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "blank email should not be valid" do 
    @user.email = "  "
    assert_not @user.valid?
  end

  test "email over 255 characters should be invalid" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "valid emails should be accepted" do 
    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test "invalid emails should be rejected" do 
    valid_emails = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    valid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be invalid"
    end
  end

  test "email must not already exist (be uniqiue) uppercase or lower" do
    duplicated_user = @user.dup
    duplicated_user.email = @user.email.upcase
    @user.save
    assert_not duplicated_user.valid?
  end

  test "email should be lowercase" do
    lower_email = "TeStiNg@GmeoL.com"
    @user.email = lower_email
    @user.save
    assert_equal lower_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should be atleast 5 characters" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "valid name and email but short password is invalid" do
    @user.name = "Test"
    @user.email = "jefe@gmail.com"
    @user.password = @user.password_confirmation = "x" * 5
    assert_not @user.valid?
  end
end
