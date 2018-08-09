require 'test_helper'

class MessagesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:lana)
  end
  
  test "message interface" do
    log_in_as(@user)
    get messages_path
    assert_template 'messages/index'

    # 無効な送信
    assert_no_difference 'Message.count' do
      post messages_path, params: { message: { to_id: @other_user.id, content: "" } }
    end
    assert_select 'div.alert-danger'
    # 有効な送信
    content = "This micropost really ties the room together"
    assert_difference 'Message.count', 1 do
      post messages_path, params: { message: { to_id: @other_user.id, content: content } }
    end
    assert_redirected_to message_path(@other_user.id)
    follow_redirect!
    assert_match content, response.body
  end
end
