require 'test_helper'

class TopicPasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get topic_passwords_new_url
    assert_response :success
  end

end
