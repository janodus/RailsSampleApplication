require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:archer)
    @other_user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
  end

  test "should redirect user index is not logged in" do
    get users_path
    assert_redirected_to login_path
  end

  test "should not redirct user index if logged in" do
    log_in_as(@user)
    get users_path
    assert_template 'index'
  end

  test "should not show login link when already logged in" do
  log_in_as(@user)
  get root_path
  assert_select "li", {count: 0, text: "Log in"}
  end

  test "should not have access to edit user page when incorrect user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_path
  end

  test "should not have account dropdown if not logged in" do
    get root_path
    assert_select "nav", {count: 0, text: "Account"}
  end

  test "should not have Users link if not logged in" do
    get root_path
    assert_select "nav", {count: 0, text: "Users"}
  end

end
