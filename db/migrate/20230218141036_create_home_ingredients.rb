class CreateHomeIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :home_ingredients do |t|
      t.string :name

      t.timestamps
    end
  end
end
