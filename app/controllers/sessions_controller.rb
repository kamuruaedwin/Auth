# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  before_action :count_online_users, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(phone_number: params[:phone_number])

    if @user&.authenticate(params[:password])
      @user.update(logged_in: true)
      login(@user)
      redirect_to root_path, notice: "You have logged in successfully."
    else
      flash.now[:alert] = "Invalid phone number or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if user_signed_in?
      current_user.update(logged_in: false)
      reset_session
      redirect_to root_path, notice: "You have been logged out successfully."
    else
      redirect_to root_path, notice: "Failed to log out."
    end
  end

  private

  # This method counts users logged in
  def count_online_users
    @online_users_count = User.where(logged_in: true).count
  end
end

