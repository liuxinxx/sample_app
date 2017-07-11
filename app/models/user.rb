class User < ApplicationRecord
  #把email的属性的值装换为小写形式，确保电子邮件的唯一性
  before_save {self.email = email.downcase}
  #限制名长度
  validates(:name,presence:true,length: {maximum: 50})
  #匹配邮箱地址的正则表达式
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #限制邮箱地址的长度、格式、唯一性 
  validates(:email,presence:true,length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX },
            uniqueness:{case_sensitive: false})
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
