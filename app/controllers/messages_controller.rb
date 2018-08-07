class MessagesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :creaete]
  def index
    @users = current_user.user_with_message
  end

  def show
    @from_user = current_user
    @to_user = User.find_by(id: params[:id])
    @messages = @from_user.messages(@to_user)
    @message = current_user.from_messages.build()
  end
  
  def create
    @message = current_user.from_messages.build(message_params)
    if @message.save
      flash[:success] = "messege sent!"
      redirect_to "/messages/#{@message.to_id}"
    else
      flash.now[:danger] = 'failed to send message'
      redirect_back_or root_url
    end
  end
  
  private

    def message_params
      params.require(:message).permit(:content, :to_id)
    end
end
