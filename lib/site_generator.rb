class SiteGenerator
  def make_index!
    index = <<-HTML
      <!DOCTYPE html>
      <html>
        <head>
          <title>Movies</title>
        </head>
        <body>
          <ul>
            #{Movie.all.map do |movie|
              "<li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>"
            end.join
            }
          </ul>
        </body>
      </html>
    HTML
    File.open("_site/index.html", "w+") {|f| f.puts index}
  end

  def generate_pages!
    Dir.mkdir '_site/movies' unless File.exist? '_site/movies'
    template = File.read('lib/templates/movie.html.erb')
    erb = ERB.new(template)
    Movie.all.each do |movie|
      File.open("_site/movies/#{movie.url}", "w+") {|f| f.puts erb.result(binding)}
    end
  end
end
