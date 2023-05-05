class MovieFacade

  # def initialize(params = {})
  #   @word = params[:search]
  #   @movie_id = params[:movie_id]
  # end

  def get_top_rated_movies
    top_rated = MovieService.new.top_rated
    top_rated[:results][0..19].map do |movie|
      top_movies = { movie: movie}
      Movie.new(top_movies)
    end
  end

  def get_searched_movies(keyword)
    searched = MovieService.new.movie_search(keyword)
    searched[:results][0..19].map do |movie|
      searched_movies =  { movie: movie }
      Movie.new(searched_movies)
    end
  end

  def get_movie_details(movie_id)
    movie_info = {
    movie: movie_deets(movie_id),
    cast:  first_10_cast_members(movie_id),
    reviews: review_info(movie_id),
    total_reviews: review_info(movie_id).count
    }
    Movie.new(movie_info)
  end

  private

  def movie_deets(movie_id)
    movie = MovieService.new.get_movie_details(movie_id)
    movie_details = { id: movie[:id],
                      title: movie[:title],
                      vote_average: movie[:vote_average],
                      runtime: movie[:runtime],
                      genres: movie[:genres].map { |genre| genre[:name] },
                      summary: movie[:overview]
                    }
  end

  def first_10_cast_members(movie_id)
    cast_members = MovieService.new.get_cast(movie_id)
    cast_members[:cast].take(10).map do |member|
      cast = { name: member[:name],
            character: member[:character]
          }
    end
  end

  def review_info(movie_id)
    reviews = MovieService.new.get_reviews(movie_id)
    reviews[:results].map do |review|
      info =  { author: review[:author],
                review: review[:content]}
    end
  end
end