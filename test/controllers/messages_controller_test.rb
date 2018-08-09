require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post messages_path, params: { message: { to_id: @other_user.id, content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

end
