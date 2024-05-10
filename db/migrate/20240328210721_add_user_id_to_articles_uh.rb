class AddUserIdToArticlesUh < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :user_id, :ints
  end
end
