require "test_helper"

class Admin::SchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_schedules_show_url
    assert_response :success
  end
end
