# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

sausage = Receipt.create title: "Sausage"
sausage.ingredients.create name: "minced meat"
sausage.ingredients.create name: "fat"
sausage.ingredients.create name: "salt and pepper"

bread = Receipt.create title: "Bread"
bread.ingredients.create name: "yeast"
bread.ingredients.create name: "flour"
bread.ingredients.create name: "water"

pizza = Receipt.create title: "Pizza"
pizza.ingredients.create name: "yeast"
pizza.ingredients.create name: "olive oil"
pizza.ingredients.create name: "flour"
pizza.ingredients.create name: "tomato souce"

HomeIngredient.create name: 'yeast'
HomeIngredient.create name: 'oil'
HomeIngredient.create name: 'flour'
HomeIngredient.create name: 'tomato'
HomeIngredient.create name: 'water'
