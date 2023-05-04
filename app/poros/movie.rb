class Movie
  attr_reader :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :cast,
              :total_reviews,
              :review_info

  def initialize(details)
   
    @title = details[:movie][:title]
    @vote_average = details[:movie][:vote_average]
    @runtime = formatted_runtime(details[:movie][:runtime]) 
    @genres = details[:movie][:genres]
    @summary = details[:movie][:summary]
    @cast = details[:cast]
    @total_reviews = details[:total_reviews]
    @review_info = details[:reviews]
  end

  private

  def formatted_runtime(runtime)
    hours = runtime / 60
    minutes = runtime % 60
    return "#{hours} hours #{minutes} minutes"
  end
end