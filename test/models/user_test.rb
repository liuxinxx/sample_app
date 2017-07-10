require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "EXample User",email: "user@example.com")
  end
  test "should be valid" do
    assert @user.valid?
  end
  # 属性存在性验证
  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
  # 长度验证
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  test "email should not be too long " do
    @user.email = "a" * 244 +"@example.com"
    assert_not @user.valid?
  end
  # 格式验证---电子邮件地址
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                               foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
#   唯一性验证---决绝重复的电子邮件
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase#测试电子邮件地址的唯一性验证不区分大小写
    @user.save
    assert_not duplicate_user.valid?
  end

end
