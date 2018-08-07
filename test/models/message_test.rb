require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @message = @user.from_messages.build(to_id: users(:archer).id, content: "test message")
  end
  
  test "should be valid" do
    assert @message.valid?
  end

  test "from id should be present" do
    @message.from_id = nil
    assert_not @message.valid?
  end
  
  test "to id should be present" do
    @message.to_id = nil
    assert_not @message.valid?
  end
  
  test "content should be present" do
    @message.content = nil
    assert_not @message.valid?
  end
  
  test "content should be 140" do
    @message.content = "a" * 141
    assert_not @message.valid?
  end
end
