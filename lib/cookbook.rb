require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = [] # instances of Recipe
    load_csv
  end

  # Return all the recipes
  def all
    @recipes
  end

  # Add a recipe to the cookbook
  def create(recipe) # instance of Recipe
    @recipes << recipe
    save_csv
  end

  # Remove a recipe from the cookbook
  def destroy(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_and_save(index)
    recipe_to_mark = @recipes[index]
    recipe_to_mark.mark_as_done!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
       # p row # array of strings

      # @recipes << Recipe.new(name: row[:name], description: row[:description])
                   # "true" == "true" => boolean true
                   # "false" == "true" => boolean false
      row[:done] = row[:done] == "true" # boolean
      @recipes << Recipe.new(row)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ["name", "description", "rating", "prep_time", "done"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end

cookbook = Cookbook.new("lib/recipes.csv")