# app/controllers/bets_controller.rb
class BetsController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :initialize_burst_value, only: [:create]
  def new
    @bet = Bet.new
    @bet.betid = SecureRandom.hex(6) # Generate a 6-character hexadecimal betid
  end

  def create
    # Simulate the animation's progress (replace this with your actual animation logic)
    @bet = current_user.bets.build(bet_params)

    @bet.betid = SecureRandom.hex(6) # Generate a 6-character hexadecimal betid

    
    if @bet.save

      #deduct stake_amount from balance on placing bet
      current_user.balance -= @bet.stake_amount
      current_user.save      
      
     
      # Output the betid to the log
      puts "Generated betid: #{@bet.betid}"

      flash[:success] = "Bet placed successfully!"
      redirect_to root_path

    else
      render :new
    end
  end



  def determine_outcome
    @bet = Bet.find(params[:id])
  # Calculate the outcome based on animation progress and predicted value
  if @burst_value >= @bet.predicted_y_value
    @bet.outcome = @bet.stake_amount * @bet.predicted_y_value
    flash[:success] = "Congratulations you won!"
  else
    @bet.outcome = 0
  end
  @bet.save
  
  # Update the user's balance based on the outcome
  current_user.balance += @bet.outcome
  current_user.save

  # Redirect or respond as needed
end

  private 

  def set_user
    @user = current_user
  end


  def initialize_burst_value
    @burst_value = 1  # Initialize with the starting value (modify as needed)
  end

  def bet_params
    params.require(:bet).permit(:stake_amount, :predicted_y_value)
  end
end
