class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show, :new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def edit
    
  end

  def update
    
    if @user.update(user_params)
      flash[:notice] = "your account thing was updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the alfa blog, #{@user.username} you have signed up and things"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user = current_user
    flash[:notice] = "account and all associated articles are deleted"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "you can only edit or delete your own profile"
      redirect_to current_user
    end
  end
end