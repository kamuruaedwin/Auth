# app/controllers/bets_controller.rb
class BetsController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :initialize_burst_value, only: [:create]
  
  def new
    @bet = Bet.new
  end
  def show
    @user = User.new 
    @bet = Bet.find(params[:id])
    if @bet.nil?
    # Handle the case where the bet is not found, e.g., redirect to an error page or show a message
    flash[:error] = "Bet not found."
    redirect_to root_path
  end
  end

  def create
    @bet = current_user.bets.build(bet_params)
    @bet.betid = SecureRandom.hex(6) # Generate a 6-character hexadecimal betid

    respond_to do |format|
      if @bet.save
        # Store the bet_id in the user's session
        session[:bet_id] = @bet.betid     
        current_user.balance -= @bet.stake_amount
        current_user.save
        # Output the betid to the log
        puts "Generated betid: #{@bet.betid}"

        format.html { redirect_to @bet, notice: 'Bet was successfully created.' }
        format.js # This line is for handling JavaScript response
        # flash[:success] = "Bet placed successfully!"
        # redirect_to root_path
      else
        # render :new
        format.html { render :new }
        format.js # This line is for handling JavaScript response
      end
    end
  end

    #Working burst_data_save
  def save_burst_data
    begin
      burst_data = params[:burst_data]
      burst_value = burst_data[:burst_value]
      hashvalue = burst_data[:hashvalue]
      betid = burst_data[:betid]

     

      # Save both burst_value and hashvalue in the database, associated with the current user
      # Adjust the code according to your model and association structure
      @burst_data = current_user.burst_data.create(burst_value: burst_value, hashvalue: hashvalue)

       # Create a new BurstData record
      @burst_data = BurstData.create(burst_value: burst_value)

       # Associate it with a bet if bet_id is provided
      if betid
        @bet = Bet.find_by(betid: betid)
        if @bet
          @burst_data.bet = @bet
          @burst_data.save
        end
      end


      if @burst_data.save
        render json: { status: 'Success', message: 'Burst data saved' }
      else
        render json: { error: @burst_data.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
  # def save_burst_data
  #   begin
  #     # Extract burst_data from the params
  #     burst_data = params[:burst_data]
  #     burst_value = burst_data[:burst_value]
  #     hashvalue = burst_data[:hashvalue]
  #     betid = burst_data[:betid] # Assuming that the betid is sent in the burst_data

  #     if betid.present?
  #       # Find the corresponding bet using the betid
  #       @bet = Bet.find_by(betid: betid)

  #       if @bet.nil?
  #         render json: { error: 'Bet not found' }, status: :unprocessable_entity
  #         return
  #       end
  #     else
  #       @bet = nil
  #     end

  #     # Create a new BurstData record
  #     @burst_data = BurstData.create(burst_value: burst_value, hashvalue: hashvalue, bet: @bet)

  #     if @burst_data.save
  #       render json: { status: 'Success', message: 'Burst data saved' }
  #     else
  #       render json: { error: @burst_data.errors.full_messages }, status: :unprocessable_entity
  #     end
  #   rescue ActiveRecord::RecordInvalid => e
  #     render json: { error: e.message }, status: :unprocessable_entity
  #   end
  # end
# endpoint to retrieve the betid
  def get_bet_id
    betid = session[:betid]
    render json: { betid: betid }
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
