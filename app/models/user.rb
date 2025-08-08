class User < ApplicationRecord
    has_many :orders, dependent: :destroy

    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    enum role: { buyer: 0, seller: 1 }
    has_many :sent_conservations, class_name: 'Conversation', foreign_key: 'sender_id' 
    has_many :received_conservation, class_name: 'Conservation', foreign_key: 'recipent_id'
    scope :by_status, ->(status) { where(status: status) if status.present? }
    scope :by_date_range, ->(start_date, end_date){ 
        where(created_at: start_date..end_date) if start_date.present? && end_date.present?
     }
     
end
