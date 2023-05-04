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

  def movie_search(title)
    response = connection.get("/3/search/movie?&query=#{title}") do |req|
      req.params["api_key"] = ENV["movie_token"]
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_movie_details(id)
    response = connection.get("/3/movie/#{id}") do |req|
      req.params["api_key"] = ENV["movie_token"]
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_cast(id)
    response = connection.get("/3/movie/#{id}/credits") do |req|
      req.params["api_key"] = ENV["movie_token"]
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_reviews(id)
    response = connection.get("/3/movie/#{id}/reviews") do |req|
      req.params["api_key"] = ENV["movie_token"]
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end