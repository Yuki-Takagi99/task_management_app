class User < ApplicationRecord
  before_destroy :admin_exist_check
  before_update :admin_update_check
  has_many :tasks, :dependent => :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  private
  def admin_exist_check
    if User.where(admin: true).count <= 1 && self.admin == true
      errors.add(:admin, "エラーです。管理ユーザーがいなくなるため、削除することはできません。")
      throw(:abort)
    end
  end

  def admin_update_check
    if User.where(admin: true).count == 1 && self.admin == false
      errors.add(:admin, "エラーです。管理ユーザーがいなくなるため、権限を外すことはできません。")
      throw(:abort)
    end
  end
end
