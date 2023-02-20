class AddCookTimeToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :receipts, :cook_time, :integer
    add_column :receipts, :prep_time, :integer
    add_column :receipts, :rating, :real
    add_column :receipts, :cuisine, :string
    add_column :receipts, :category, :string
    add_column :receipts, :author, :string
    add_column :receipts, :image, :string
  end
end
