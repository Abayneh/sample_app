require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show' # Show the user info
    assert_select "a[href=?]", login_path, count: 0 # no more login path
    assert_select "a[href=?]", logout_path # logout must be present
    assert_select "a[href=?]", user_path(@user) #user path must be present
    delete logout_path # (when logout) the logout path must not be present
    assert_not is_logged_in? # No longer logged in
    assert_redirected_to root_url #self explanatory
    # Simulate a user clicking logout in a second window
    delete logout_path #....
    follow_redirect! # verify the page is on the root
    assert_select "a[href=?]", login_path # check login path is present again
    assert_select "a[href=?]", logout_path, count: 0 # check no more logout path exists
    assert_select "a[href=?]", user_path(@user), count: 0 # check user info no more exists.
  end
  
end