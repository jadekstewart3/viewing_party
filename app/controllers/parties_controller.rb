class PartiesController < ApplicationController
  def new
    if current_user.nil?
      flash[:error] = "You must be logged in or register to continue."
      redirect_to user_movie_path(params[:user_id], params[:movie_id])
    else
      @user = current_user
      @movie = MovieFacade.new.get_movie_details(params[:movie_id])
    
      @users = User.all
    end
  end

    def create
      user = current_user
      @movie = MovieFacade.new.get_movie_details(params[:movie_id])
      new_party = Party.new(party_attributes)
      if new_party.save
        PartyUser.create(user: user, party: new_party, host: user)
        params[:users].each do |user_id|
          next if user_id.empty? || user_id == user.id.to_s
          PartyUser.create!(user: User.find(user_id.to_i), party: new_party, host: false )
        end
        redirect_to dashboard_path
      else
        redirect_to new_user_movie_party_path(user, @movie.movie_id)
        flash[:error] = error_message(new_party.errors)
      end
    end
  private

  def party_attributes
    params.permit(:duration, :start_time, :date, :movie_id, :host_id)
  end
end