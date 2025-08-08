class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"

    stream_from "chat_#{params[:conversation_id]}"  
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast("chat_#{params[:conversation_id]}", { message: data['message'] })
  end

end
