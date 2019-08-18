class Event < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  scope :order_id, -> { order(id: :asc) }
end
