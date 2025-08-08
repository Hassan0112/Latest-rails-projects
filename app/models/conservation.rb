class Conversation < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :recipient, class_name: 'User'
    has_many :messages, dependent: :destroy

    scope :between, ->(user_a_id, user_b_id){
        where(sender_id: user_a_id, recipient_id: user_b_id)
        .or(where(sender_id: user_b_id, recipient_id: user_a_id))
    }
end
        
        