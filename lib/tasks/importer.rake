desc "Import the recipes"
namespace :import do
  task recipes: :environment do
    raw_data = File.read('recipes-en.json')
    recipes = JSON.parse(raw_data)
    not_parsed_recipes = []
    recipes.each_with_index do |recipe, index|
      puts "Recipe:#{recipe["title"]}"
      recipe["ingredients"].each do |ingredient_for_recipe|
        puts "Parsing: #{ingredient_for_recipe}"
        ingredient = Ingreedy.parse(ingredient_for_recipe)
        puts "Amount: #{ingredient.amount}"
        puts "Unit: #{ingredient.unit}"
        puts "Ingredient: #{ingredient.ingredient}"
      rescue
        not_parsed_recipes << recipe
      end
      puts "Indexed #{index +1} recipe"
    end
    puts "Not able to parse: #{not_parsed_recipes.length} recipes"
    puts "Totally indexed recipes: #{recipes.length - not_parsed_recipes.length}"
    puts "---"
    puts "Recipes not parsed:"
    not_parsed_recipes.each do |not_parsed_recipe|
      puts "Title: #{not_parsed_recipe["title"]}"
      puts not_parsed_recipe
    end
  end
end
