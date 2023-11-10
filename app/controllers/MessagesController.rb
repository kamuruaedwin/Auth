# Messages Controller
class MessagesController < ApplicationController
  before_action :authenticate_user!

def index
  @messages = Message.order(created_at: :desc)

  respond_to do |format|
    format.json { render partial: 'chartform', locals: { messages: @messages } }
  end
end




  def messages
    render partial: 'messages'
  end

def create
  @user = current_user
  @message = @user.messages.new(message_params)
  # @message = current_user.messages.build(message_params)

  respond_to do |format|
    if @message.save
      @messages = Message.order(created_at: :desc) # Fetch messages
      flash[:notice] = 'Message posted successfully.'
      # format.html { redirect_to messages_path }
      format.js
    else
       flash[:alert] = 'Failed to post the message.'
      # format.html { render 'new' }
      format.js { render 'create_failure.js.erb' } # Create this file for error handling
    end
  end
end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end