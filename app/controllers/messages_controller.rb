class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    if @message.save
      #show messages to specific channel like chat_1 oR chat_2(conversation.id )channel_id
      #render_to_string: Generates HTML as a string, so we can send it somewhere else (like over WebSocket).
      ActionCable.server.broadcast(
        "chat_#{conversation.id}",
        render_to_string(partial: "messages/message", local: {message: @message})
      )
      redirect_to conversation_path(@conversation)
    else
      @messages = @conversation.messages.order(created_at: :asc)
      render 'conversations/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
