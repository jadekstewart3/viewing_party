class MovieService
  def connection
    url = "https://api.themoviedb.org"
    Faraday.new(url: url)
  end

  def top_rated
    response = connection.get("/3/movie/top_rated") do |req|
      req.params["api_key"] = ENV["movie_token"]
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end