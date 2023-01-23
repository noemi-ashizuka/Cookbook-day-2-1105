require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

class ScrapeAllrecipesService
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    # file = "garlic.html"
    url = "https://www.allrecipes.com/search?q=#{@ingredient}"
    doc = Nokogiri::HTML.parse(URI.open(url).read, nil, "utf-8")
    recipes = []
    doc.search('.mntl-card-list-items.card').each do |element|
      unless element.search('.recipe-card-meta__rating-count').empty?
        name = element.search('.card__title-text').text.strip
        rating = element.search('.icon-star').count + element.search('.icon-star-half').count * 0.5
        details_url = element.attribute('href').value
        details_doc = Nokogiri::HTML.parse(URI.open(details_url).read, nil, "utf-8")
        description = details_doc.search(".article-subheading").text.strip
        prep_time = details_doc.search('.mntl-recipe-details__value').first.text.strip
        recipes << Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
        # url = find url to recipe details
        # use http URI.open("url")
        # parse it with nokogiri
        # get description 
        # get prep time
      end
    end
    # return array of 5 recipes instances
    recipes.first(5)
  end

end



# scraper = ScrapeAllrecipesService.new('garlic')
# scraper.call
