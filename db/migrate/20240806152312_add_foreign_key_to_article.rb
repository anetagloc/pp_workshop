class AddForeignKeyToArticle < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :articles, :users
  end
end
