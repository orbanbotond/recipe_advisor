class AddIndexToNameOnIngredients < ActiveRecord::Migration[7.0]
  def change
    add_index :ingredients, :name
    add_index :home_ingredients, :name
  end
end
