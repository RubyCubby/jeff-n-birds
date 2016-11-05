require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "don't allow invalid submission" do
    get signup_path
    assert_no_difference 'User.count' do #Check for a difference in User.count before and after! Genius
      post users_path, params: {
        user: {
          name: "John",
          email: "kdkd",
          password: "",
          password_confirmation: ""
        }
      }
    end
    assert_template 'users/new' #Check for the rendering of the 'new' template
  end

  test "check for error messages" do
    get signup_path
    post users_path, params: {
      user: {
        name: "",
        email: "",
        password: "",
        password_confirmation: ""
      }
    }
    assert_template 'users/new'
    assert_select "div.field_with_errors"
    assert_select "div#error_explanation"
  end
  
  test "check that a user was created" do 
    assert_difference 'User.count', 1 do 
      get signup_path
      post users_path, params: {
        user: {
          name: "jeffhage",
          email: "jeffhage@test.com",
          password: "test12345",
          password_confirmation: "test12345"
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
  end

  test "flash message exists after created" do 
    assert_difference 'User.count' do 
      get signup_path
      post users_path, params: {
        user: {
          name: "jeffhage",
          email: "jeffhage@test.com",
          password: "test12345",
          password_confirmation: "test12345"
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.alert-success'
  end
end
