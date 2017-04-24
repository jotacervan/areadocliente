require 'test_helper'

class CoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cores_index_url
    assert_response :success
  end

  test "should get new" do
    get cores_new_url
    assert_response :success
  end

  test "should get show" do
    get cores_show_url
    assert_response :success
  end

  test "should get edit" do
    get cores_edit_url
    assert_response :success
  end

  test "should get create" do
    get cores_create_url
    assert_response :success
  end

  test "should get update" do
    get cores_update_url
    assert_response :success
  end

  test "should get destroy" do
    get cores_destroy_url
    assert_response :success
  end

end
