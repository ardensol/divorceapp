require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post :create, profile: { bar_id: @profile.bar_id, blurb: @profile.blurb, claimed: @profile.claimed, description: @profile.description, email: @profile.email, law_school: @profile.law_school, name: @profile.name, phone_number: @profile.phone_number, state: @profile.state, user_id: @profile.user_id }
    end

    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should show profile" do
    get :show, id: @profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile
    assert_response :success
  end

  test "should update profile" do
    patch :update, id: @profile, profile: { bar_id: @profile.bar_id, blurb: @profile.blurb, claimed: @profile.claimed, description: @profile.description, email: @profile.email, law_school: @profile.law_school, name: @profile.name, phone_number: @profile.phone_number, state: @profile.state, user_id: @profile.user_id }
    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete :destroy, id: @profile
    end

    assert_redirected_to profiles_path
  end
end
