class RegistrationsController < ApplicationController
  def new
    @user = User.new
    p @user #debug purpose
  end

  def create
    @user = User.new(registration_params) # Use parentheses instead of square brackets
    if @user.save
      @user.update(balance: 8.0)
      session[:user_id] = @user.id
      login @user
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end 
  end

  private
  
  def registration_params #Correct the method name here
    params.require(:user).permit(:username, :phone_number, :password, :password_confirmation)
  end
end
