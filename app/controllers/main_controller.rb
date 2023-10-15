class MainController < ApplicationController
	# def index
	# 	@messages = Message.order(created_at: :desc)
	# 	@messages = Message.all # Or fetch messages from your database
	# end

	def index
	    @bet = Bet.new
	    @bet.betid = SecureRandom.hex(6) # Generate a 6-character hexadecimal betid
  	end
end