require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_allrecipes_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_all
  end

  def add
    # 1. Ask the user for a name and description
    name = @view.ask_for('name')
    description = @view.ask_for('description')
    rating = @view.ask_for('rating')
    prep_time = @view.ask_for('prep time')
    # 2. Use the name and description to make a recipe instance
    recipe = Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
    # 3. Put the recipe into the cookbook
    @cookbook.create(recipe)
  end

  def remove
    # Display the recipes
    display_all
    # Ask the user for the index of the recipe to remove
    index = @view.ask_for_index
    # Tell the cookbook to destroy the recipe at this index
    @cookbook.destroy(index)
  end

  def import
    # Ask a user for a keyword to search
    keyword = @view.ask_for("keyword")
    # Make an HTTP request to the recipe’s website with our keyword
    # Parse the HTML document to extract the first 5 recipes suggested and store them in an Array
    recipes = ScrapeAllrecipesService.new(keyword).call # array of recipes instances
    # Display them in an indexed list
    @view.display(recipes)
    # Ask the user which recipe they want to import (ask for an index)
    index = @view.ask_for_index
    # Add it to the Cookbook
    recipe = recipes[index] # recipe instance
    @cookbook.create(recipe)
  end

  def mark_as_done
    # display the recipes
    display_all
    # ask user for index
    index = @view.ask_for_index
    @cookbook.mark_and_save(index)
    # mark it
  end

  private

  def display_all
    # 1. Ask the cookbook for the recipes
    recipes = @cookbook.all
    # 2. Display the list of recipes
    @view.display(recipes)
  end
end
