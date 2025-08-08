import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { conversationId: Number }

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "ChatChannel", conversation_id: this.conversationIdValue },
      {
        received: (data) => {
          // Append the new message HTML to the message container
          this.element.insertAdjacentHTML("beforeend", data)
        }
      }
    )
  }

  disconnect() {
    this.channel.unsubscribe()
  }
}
