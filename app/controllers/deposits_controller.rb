
# app/controllers/deposits_controller.rb
class DepositsController < ApplicationController
  def new
    @deposit = Deposit.new
  end

  def create
    @deposit = current_user.deposits.build(deposit_params)
    if @deposit.save
      # Call the M-Pesa API to initiate the payment here
      # Handle the payment response and update the user's account balance
      flash[:success] = 'Deposit successful'
      redirect_to root_path
    else
      flash[:error] = 'Deposit failed'
      render :new
    end
  end

  private

  def deposit_params
    params.require(:deposit).permit(:amount)
  end
end
