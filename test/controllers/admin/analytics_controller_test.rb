require 'test_helper'

class Admin::AnalyticsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin    = users(:michael)
    @non_admin = users(:archer)
  end

  test "should redirect index when not logged in" do
    get admin_analytics_path
    assert_redirected_to login_url
  end

  test "should redirect index when logged in as non-admin" do
    log_in_as(@non_admin)
    get admin_analytics_path
    assert_redirected_to root_url
  end

  test "should get index when logged in as admin" do
    log_in_as(@admin)
    get admin_analytics_path
    assert_response :success
    assert_select 'h1', 'Admin Analytics'
  end

  test "should show top users table" do
    log_in_as(@admin)
    get admin_analytics_path
    assert_select 'h3', 'Top Users by Microposts'
    assert_select 'table.table' do
      assert_select 'th', 'User'
      assert_select 'th', 'Microposts'
      assert_select 'tr td', @admin.name
    end
  end

  test "should show recent microposts" do
    log_in_as(@admin)
    get admin_analytics_path
    assert_select 'h3', 'Recent Microposts'
    assert_select 'ol.microposts li'
  end

  test "should limit top users to 10" do
    log_in_as(@admin)
    get admin_analytics_path
    assert_select 'table.table tbody tr', count: (0..10)
  end

  test "should limit recent posts to 10" do
    log_in_as(@admin)
    get admin_analytics_path
    assert_select 'ol.microposts li', count: (0..10)
  end
end
