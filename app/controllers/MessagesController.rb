# Messages Controller
class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.order(created_at: :desc)
  end

  def create
    @message = Message.new(message_params)
    # @message = current_user.messages.build(message_params)
    if @message.save
      flash[:notice] = 'Message posted successfully.'
    else
     flash[:alert] = 'Failed to post the message.'
    end
    @messages = Message.order(created_at: :desc) # Fetch messages
    render :index # Render the index view
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end