class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if params[:title]
      @movies = MovieFacade.new.get_searched_movies(params[:title])
    else
      @movies = MovieFacade.new.get_top_rated_movies
    end
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MovieFacade.new.get_movie_details(params[:id])
  end
end