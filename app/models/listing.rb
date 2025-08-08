class Listing < ApplicationRecord
  belongs_to :user           # the seller
  monetize :price_cents       # if using money-rails gem (optional)
  include Elasticsearch::Model  # see next section
  include Elasticsearch::Model::Callbacks

  # any validations, e.g.:
  validates :title, :price_cents, presence: true
end
