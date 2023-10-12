# app/controllers/bets_controller.rb
class BetsController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :initialize_burst_value, only: [:create]
  
  def new
    @bet = Bet.new
    @bet.betid = SecureRandom.hex(6) # Generate a 6-character hexadecimal betid
  end

  def create
    @bet = current_user.bets.build(bet_params)
    @bet.betid = SecureRandom.hex(6) # Generate a 6-character hexadecimal betid

    if @bet.save
      # Deduct stake_amount from balance on placing the bet
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

  # In your Rails controller (bets_controller.rb)
def save_burst_data
  begin
    burst_data = params[:burst_data]
    burst_value = burst_data[:burst_value]
    hashvalue = burst_data[:hashvalue]

    # Save both burst_value and hashvalue in the database, associated with the current user
    # Adjust the code according to your model and association structure
    @burst_data = current_user.burst_data.create(burst_value: burst_value, hashvalue: hashvalue)

    if @burst_data.save
      render json: { status: 'Success', message: 'Burst data saved' }
    else
      render json: { error: @burst_data.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end


  def determine_outcome
    @bet = Bet.find(params[:id])
    # Calculate the outcome based on animation progress and predicted value
    if @burst_value >= @bet.predicted_y_value
      @bet.outcome = @bet.stake_amount * @bet.predicted_y_value
      flash[:success] = "Congratulations, you won!"
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
    # Initialize @burst_value with the starting value (modify as needed)
    @burst_value = 1
  end

  def bet_params
    params.require(:bet).permit(:stake_amount, :predicted_y_value)
  end
end
