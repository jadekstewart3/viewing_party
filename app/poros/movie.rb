class Movie
  attr_reader :movie_id,
              :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :cast,
              :total_reviews,
              :review_info,
              :poster_path

  def initialize(details)
    @movie_id = details[:movie][:id]
    @title = details[:movie][:title]
    @vote_average = details[:movie][:vote_average]
    @runtime = formatted_runtime(details[:movie][:runtime]) 
    @genres = details[:movie][:genres]
    @summary = details[:movie][:summary]
    @cast = details[:cast]
    @total_reviews = details[:total_reviews]
    @review_info = details[:reviews]
    @poster_path = details[:movie][:poster_path]
  end

  private
  def formatted_runtime(runtime)
    unless runtime == nil
      hours = runtime / 60
      minutes = runtime % 60
      return "#{hours}:#{minutes}"
    end
  end
end