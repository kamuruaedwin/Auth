class MainController < ApplicationController
	def index
		@user = User.new # Initialize a new User instance
		@bets = Bet.where(settled: false)
		@messages = Message.order(created_at: :desc)
		@messages = Message.all # Or fetch messages from your database
		@message = Message.new #initializing an empty message object for the form
	    @bet = Bet.new
	    @bet.betid = SecureRandom.hex(6) # Generate a 6-character hexadecimal betid
  	end
end