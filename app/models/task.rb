class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30}
  validates :description, presence: true
  enum status: { '未着手':0, '着手中':1, '完了':2 }
  enum priority: { '高':0, '中':1, '低':2 }
  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :search_status, -> (search_status) { where(status: search_status) }
  scope :seach_label, -> (search_label) { joins(:labels).where(search_label) }
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
end
