class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_current_user_profile?, only: [:edit, :update]
  def index
      @book = Book.new
      @users = User.all
      @user = current_user
  end

  def show
      @user = User.find(params[:id])
      @book = @user.books
      @user.id.to_i
  end

  def new
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "successfully"
         redirect_to user_path(@user.id)
      else
         flash[:notice] = "error"
         render :edit
      end
  end

  private
  def user_params
     params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def check_current_user_profile?
       user = User.find(params[:id])
       unless current_user.id == user.id
         redirect_to user_path(current_user.id)
       end
   end
end
