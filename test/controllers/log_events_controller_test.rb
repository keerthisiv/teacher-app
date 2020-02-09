require 'test_helper'

class LogEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @log_event = log_events(:one)
  end

  test "should get index" do
    get log_events_url
    assert_response :success
  end

  test "should get new" do
    get new_log_event_url
    assert_response :success
  end

  test "should create log_event" do
    assert_difference('LogEvent.count') do
      post log_events_url, params: { log_event: { description: @log_event.description, event_time: @log_event.event_time, event_type: @log_event.event_type, teacher: @log_event.teacher } }
    end

    assert_redirected_to log_event_url(LogEvent.last)
  end

  test "should show log_event" do
    get log_event_url(@log_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_log_event_url(@log_event)
    assert_response :success
  end

  test "should update log_event" do
    patch log_event_url(@log_event), params: { log_event: { description: @log_event.description, event_time: @log_event.event_time, event_type: @log_event.event_type, teacher: @log_event.teacher } }
    assert_redirected_to log_event_url(@log_event)
  end

  test "should destroy log_event" do
    assert_difference('LogEvent.count', -1) do
      delete log_event_url(@log_event)
    end

    assert_redirected_to log_events_url
  end
end
