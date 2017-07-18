class User < ApplicationRecord
  attr_accessor :remember_token

  #把email的属性的值装换为小写形式，确保电子邮件的唯一性
  before_save {self.email = email.downcase}
  #限制名长度
  validates(:name,presence:true,length: {maximum: 50})
  #匹配邮箱地址的正则表达式
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  #验证数据   ----    限制邮箱地址的长度、格式、唯一性
  validates(:email,presence:true,length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX },
            uniqueness:{case_sensitive: false})
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  #返回指定字符串的哈希摘要
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #返回一个随机令牌
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest,User.digest(remember_token))

  end
  #如果指定的令牌和摘要匹配，返回 true
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  #忘记用户
  def forget
    update_attribute(:remember_digest,nil)
  end
end
