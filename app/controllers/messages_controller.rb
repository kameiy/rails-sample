class MessagesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :create]
  def index
    @users = current_user.user_with_message
  end

  def show
    @from_user = current_user
    @to_user = User.find_by(id: params[:id])
    @messages = @from_user.messages(@to_user)
    @message = current_user.from_messages.build()
    render 'show'
  end
  
  def create
    @message = current_user.from_messages.build(message_params)
    if @message.save
      flash[:success] = "messege sent!"
      redirect_to "/messages/#{@message.to_id}"
    else
      flash.now[:danger] = 'failed to send message'
      params[:id] = @message.to_id
      show
    end
  end
  
  private

    def message_params
      params.require(:message).permit(:content, :to_id)
    end
end
