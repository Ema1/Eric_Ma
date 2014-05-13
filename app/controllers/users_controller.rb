class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @pizzaposts = @user.pizzaposts.paginate(page: params[:page])
  end
  
  def new
	@user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Pizza Market! start creating Pizza!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
  
end
