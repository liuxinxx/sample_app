class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  def change
    # 为users表建立索引，索引本身并不能保证唯一 性，所以还要指定 unique: true。
    add_index :users,:email,unique: true
  end
end
