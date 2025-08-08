class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where("sender_id = :id OR recipient_id = :id", id: current_user.id)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = conversation.messages.order(created_at: :asc)
    @message      = Message.new
  end

  def create
    @conversation = Conversation.between(current_user.id, params[:recipient_id]).first_or_create!(
      sender_id: current_user.id,
      recipient_id: params[:recipient_id]
    )
    redirect_to conversation_path(@conversation)
  end
end
