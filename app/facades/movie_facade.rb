class MovieFacade
  attr_reader :search,
              :movie_id

  def initialize(params = {})
    @word = params[:search]
    @movie_id = params[:movie_id]
  end

  def get_top_rated_movies
    top_rated = MovieService.new.top_rated
    top_rated[:results][0..19].map do |movie|
      top_movies = { movie: movie}
      Movie.new(top_movies)
    end
  end

  def get_searched_movies
    searched = MovieService.new.movie_search(@word)
    searched[:results][0..19].map do |movie|
      searched_movies =  { movie: movie }
      Movie.new(searched_movies)
    end
  end

  def get_movie_details
    movie_info = {
    movie: movie_deets,
    cast:  first_10_cast_members,
    reviews: review_info,
    total_reviews: review_info.count
    }
    Movie.new(movie_info)
  end

  private

  def movie_deets
    movie = MovieService.new.get_movie_details(@movie_id)
    movie_details = { title: movie[:title],
                      vote_average: movie[:vote_average],
                      runtime: movie[:runtime],
                      genres: movie[:genres].map { |genre| genre[:name] },
                      summary: movie[:overview]
                    }
  end

  def first_10_cast_members
    cast_members = MovieService.new.get_cast(@movie_id)
    cast_members[:cast].take(10).map do |member|
      cast = { name: member[:name],
            character: member[:character]
          }
    end
  end

  def review_info
    reviews = MovieService.new.get_reviews(@movie_id)
    reviews[:results].map do |review|
      info =  { author: review[:author],
                review: review[:content]}
    end
  end
end