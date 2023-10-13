class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
  @user = User.new(user_params)

    if @user.save
      # Set the initial balance for the user
      @user.update(balance: 8.0)

      # Log the user in after successful registration
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'Registration successful!'
    else 
      flash[:register_errors] = user.errors.full_messages
      render :new
    end
  end

  private

    def user_params
      # params.require(:user).permit(:firstname, :middlename, :username, :phone_number, :password, :password_confirmation)
      params.require(:user).permit(:username, :phone_number, :password, :password_confirmation)
    end

end
