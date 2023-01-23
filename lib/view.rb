class View
  def display(recipes)
    puts '=' * 20
    puts 'Here are the recipes in your Cookbook:'
    recipes.each_with_index do |recipe, index|
      x_mark = recipe.done? ? "X" : " "
      puts "#{index + 1}. [#{x_mark}] #{recipe.name} - #{recipe.description} - prep time: #{recipe.prep_time} (#{recipe.rating}/5)"
    end
    puts '=' * 20
  end

  def ask_for(thing)
    puts "What is the #{thing}?"
    print '> '
    gets.chomp
  end

  def ask_for_index
    puts "Which recipe number?"
    print '> '
    gets.chomp.to_i - 1
  end
end
