desc "Import the recipes"
namespace :import do
  task recipes: :environment do
    raw_data = File.read('recipes-en.json')
    recipes = JSON.parse(raw_data)
    not_parsed_recipes = []
    recipes.each do |recipe|
      receipt = Receipt.create title: recipe["title"],
                     cook_time: recipe["cook_time"],
                     prep_time: recipe["prep_time"],
                     rating: recipe["rating"],
                     cuisine: recipe["cuisine"],
                     category: recipe["category"],
                     author: recipe["author"],
                     author: recipe["author"],
                     image: recipe["image"]
      recipe["ingredients"].each do |ingredient_for_recipe|
        receipt.ingredients.create name: ingredient_for_recipe
      rescue
        not_parsed_recipes << recipe
      end
      puts "Indexed #{Receipt.count } recipes"
    end
    puts "Not able to parse: #{not_parsed_recipes.length} recipes"
    puts "Totally indexed recipes: #{Receipt.count - not_parsed_recipes.length}"
    puts "---"
    puts "Recipes not parsed:"
    not_parsed_recipes.each do |not_parsed_recipe|
      puts "Title: #{not_parsed_recipe["title"]}"
      puts not_parsed_recipe
    end
  end
end
