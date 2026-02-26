class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @events = @user.events_as_admin
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profil mis à jour !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def correct_user
    unless current_user.id == params[:id].to_i
      redirect_to root_path, alert: "Accès non autorisé."
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :avatar)
  end
end
