class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  before_filter :signed_in_user, :only => [:new, :create]

  def new
    @user = User.new
    @title = 'Sign up'
  end

  def index
    @title = 'All users'
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      @title = 'Sign up'
      render 'new'
    end
  end

  def edit
    @title = 'Edit user'
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = 'Profile updated.'
      redirect_to @user
    else
      @title = 'Edit user'
      render 'edit'
    end
  end

  def destroy
    user_to_destroy = User.find(params[:id])
    if current_user?(user_to_destroy)
      flash[:error] = 'Sorry, you cannot destroy yourself.'
      redirect_to root_path
    else
      user_to_destroy.destroy
      flash[:success] = 'User destroyed.'
      redirect_to users_path
    end
  end

  private
    
    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def signed_in_user
      if signed_in?
        redirect_to(root_path)
      end
    end
end
