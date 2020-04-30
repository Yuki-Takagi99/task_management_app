class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30}
  validates :description, presence: true

  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :search_status, -> (search_status) { where(status: search_status) }
end
