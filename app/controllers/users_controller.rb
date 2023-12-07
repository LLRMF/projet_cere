class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @guest_list = @user.guest_list
    @menu = @user.menu
    @wishlist = @user.wishlist
    @photos = @user.photos
    @guest_book = @user.guest_book
    @fund = @user.fund
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'Votre profil a été mis à jour.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :email, :password, :password_confirmation, :current_password)
  end
end
