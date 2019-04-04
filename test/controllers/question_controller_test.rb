require 'test_helper'

class QuestionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get question_index_url
    assert_response :success
  end

  test "should get show" do
    get question_show_url
    assert_response :success
  end

end
