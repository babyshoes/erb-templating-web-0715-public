class Movie
  attr_reader :title, :release_date, :director, :summary

  @@movies = []

  def self.all
    @@movies
  end

  def self.reset_movies!
    @@movies.clear
  end

  def self.make_movies!
    File.open('spec/fixtures/movies.txt').map do |line|
      movie = line.split(" - ")
      Movie.new(movie[0], movie[1].to_i, movie[2], movie[3])
    end
  end

  def self.recent
    @@movies.select {|movie| movie.release_date >= 2012}
  end

  def initialize(title, release_date, director, summary)
    @title = title
    @release_date = release_date
    @director = director
    @summary = summary
    @@movies << self
  end

  def url
    title.downcase.gsub(" ", "_") + ".html"
  end

end
