class WithdrawController < ApplicationController
	def new
    @withdraw = Withdraw.new
  end

  def create
    @withdraw = current_user.withdraw.build(withdraw_params)
    if @withdraw.save
      #Create the Withdrawal handling here
      # Call the M-Pesa API to initiate the withdrawal here
      # Handle the payment response and update the user's account balance
      flash[:success] = 'Withdraw successful'
      redirect_to root_path
    else
      flash[:error] = 'Withdraw failed'
      render :new
    end
  end

  private

  def withdraw_params
    params.require(:withdraw).permit(:amount)
  end
end
