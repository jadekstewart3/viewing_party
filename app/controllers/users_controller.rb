class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = user_params  
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    session[:user_id] = new_user.id
    if new_user.save
      redirect_to dashboard_path
    else
      redirect_to register_path
      flash[:error] = error_message(new_user.errors)
    end 
  end

  def show
    if current_user
     @user = current_user
    else
      flash[:error] = "You must be logged in to access your dashboard."
      redirect_to root_path
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to dashboard_path
    else
      flash[:error] = "Sorry your credentials are bad."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private
   def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end