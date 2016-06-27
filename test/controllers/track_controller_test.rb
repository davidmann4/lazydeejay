require 'test_helper'

class TrackControllerTest < ActionController::TestCase
  test "should get all" do
    get :all
    assert_response :success
  end

end
