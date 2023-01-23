class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name] # hash_name[key] CRUD READ
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false # boolean
  end

  def done?
    @done
  end
  
  def mark_as_done!
    @done = !@done
  end
end

# p recipe = Recipe.new(description: "yummy", name: "cake")
