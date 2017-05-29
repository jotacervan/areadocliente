require 'test_helper'

class HopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hops_index_url
    assert_response :success
  end

  test "should get create" do
    get hops_create_url
    assert_response :success
  end

  test "should get new" do
    get hops_new_url
    assert_response :success
  end

  test "should get edit" do
    get hops_edit_url
    assert_response :success
  end

  test "should get show" do
    get hops_show_url
    assert_response :success
  end

  test "should get update" do
    get hops_update_url
    assert_response :success
  end

  test "should get destroy" do
    get hops_destroy_url
    assert_response :success
  end

end
