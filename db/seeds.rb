# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require "json"
require "open-uri"

# puts "Creating movies database"
# Movie.delete_all

# 10.times do
#   movie = Movie.create(
#     title: Faker::Movie.title,
#     overview: Faker::Movie.quote,
#     poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
#     rating: rand(1.0..10.0).round(1)
#   )
#   puts "Title: #{movie.title}, #{movie.rating}"
# end

# puts "Finished"

Movie.delete_all

url = "http://tmdb.lewagon.com/movie/top_rated"
movie_serialized = URI.open(url).read
movies = JSON.parse(movie_serialized)

movies["results"].each do |movie|
  movie = Movie.create(
        title: movie['title'],
        overview: movie['overview'],
        poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
        rating: movie['vote_average']
      )
  puts "Title: #{movie.title}, #{movie.rating}, #{movie.poster_url}"
end

puts "Finished! Added #{Movie.count} movies into the movies database"
