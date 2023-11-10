# app/controllers/bets_controller.rb
class BetsController < ApplicationController
  before_action :set_user, only: [:create]

  
  def new
    @bet = Bet.new
  end
  
  def show
    @user = User.new
    @bet = Bet.find_by(id: params[:id])
    if @bet.nil?
      flash[:error] = "Bet not found."
      redirect_to root_path
    end
  end

def create
  @bet = current_user.bets.build(bet_params)
  @bet.betid = SecureRandom.hex(6)
  @bet.burst_value = 0
  @bet.total_outcome = 0
  @bet.settled = false

  if @bet.save
    session[:bet_id] = @bet.betid
    current_user.balance -= @bet.stake_amount
    current_user.save

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Bet was successfully created.' }
      format.js # You can render JavaScript here for AJAX requests
    end
  else
    respond_to do |format|
      format.html { render :new }
      format.js # You can render JavaScript here for AJAX requests
    end
  end
end

def live_bets
  @user = User.find(current_user.id)
  @bets = Bet.where(settled: false)
  render 'live_bets', layout: false
end


# Working burst_data_save
def save_burst_data
  begin
    burst_data = params[:burst_data]
    burst_value = burst_data[:burst_value]
    hashvalue = burst_data[:hashvalue]

    # Save both burst_value and hashvalue in the database, associated with the current user
    # Adjust the code according to your model and association structure
    @burst_data = current_user.burst_data.create(burst_value: burst_value, hashvalue: hashvalue)

    # Initialize total_outcome to 0
    total_outcome = 0

    # Find all bets with burst_value set to 0
    bets = Bet.where(burst_value: 0)

    # Check if there are any bets to update
    if bets.empty?
      render json: { status: 'No bets to update', message: 'No bets without burst_value found' }
    else
      bets.each do |bet|
        # Update each bet's burst_value
        bet.update(burst_value: burst_value, hashvalue: hashvalue, settled: true)

        # Calculate the bet outcome based on the updated burst_value
        if bet.predicted_y_value.present? && bet.stake_amount.present?
          if burst_value.to_f >= bet.predicted_y_value.to_f
            bet.outcome = bet.stake_amount * bet.predicted_y_value
          else
            bet.outcome = 0
          end
        else
          # Handle the case where predicted_y_value or stake_amount is nil
          bet.outcome = 0
        end

        total_outcome += bet.outcome
        # Save the updated bet
        bet.save
      end

      # Update the user's balance based on the total outcome
      current_user.balance += total_outcome
      current_user.save

      render json: { status: 'Success', message: 'Burst values and outcomes updated for eligible bets' }
    end
  rescue => e
    Rails.logger.error "Error in save_burst_data: #{e.message}"
    render json: { status: 'Error', message: 'Internal Server Error' }, status: :internal_server_error
  end
end



# app/controllers/bets_controller.rb
def bet_history
  @user = current_user
  @bets = @user.bets # Assuming you have an association between users and their bets
end



  private 

  def set_user
    @user = current_user
  end

  def bet_params
    params.require(:bet).permit(:stake_amount, :predicted_y_value)
  end
end