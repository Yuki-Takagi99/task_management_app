class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30}
  validates :description, presence: true
  enum priority: { "高":0, "中":1, "低":2 }
  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :search_status, -> (search_status) { where(status: search_status) }
end
