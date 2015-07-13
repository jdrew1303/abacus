require 'test_helper'

class PlaySegmentsControllerTest < ActionController::TestCase
  setup do
    @play_segment = play_segments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:play_segments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create play_segment" do
    assert_difference('PlaySegment.count') do
      post :create, play_segment: {  }
    end

    assert_redirected_to play_segment_path(assigns(:play_segment))
  end

  test "should show play_segment" do
    get :show, id: @play_segment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @play_segment
    assert_response :success
  end

  test "should update play_segment" do
    patch :update, id: @play_segment, play_segment: {  }
    assert_redirected_to play_segment_path(assigns(:play_segment))
  end

  test "should destroy play_segment" do
    assert_difference('PlaySegment.count', -1) do
      delete :destroy, id: @play_segment
    end

    assert_redirected_to play_segments_path
  end
end
