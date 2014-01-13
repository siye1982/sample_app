# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  has_secure_password

  #存在性验证, 长度验证
  validates :name, presence: true, length: { maximum: 50 }

  #在保存之前将字符转成小写
  before_save { |user| user.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #邮箱存在性验证, 邮箱格式正则验证, 唯一性验证并且不区分大小写
  #唯一性验证无法保证真正的唯一性,如果快速点击两次保存,这可能区分不出来唯一性.这时需要给该字段建立索引然后在索引上添加唯一性验证
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }

  validates :password_confirmation, presence: true
end