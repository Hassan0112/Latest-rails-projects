require 'rails_helper'

RSpec.describe ChatChannel, type: :channel do
  let(:user) { create(:user) }  # Create a user using FactoryBot
  let(:room) { 1 }  # Room ID for the chat (can be dynamic)
  let(:message_data) { { 'message' => 'Hello, world!' } }

  before do
    # Set the current user manually in the connection (since sign_in isn't available for ActionCable)
    stub_connection current_user: user
  end

  it 'broadcasts a message to the correct channel' do
    # Subscribe to the channel with the room parameter
    subscribe(conversation_id: room)

    # Expect the broadcast to happen when the `speak` method is called
    expect {
      perform :speak, message_data
    }.to have_broadcasted_to("chat_#{room}").with(message: 'Hello, world!')
  end
end
