class MainController < ApplicationController
	def index
		@messages = Message.order(created_at: :desc)
		# @bet = Bet.find(params[:id])
	end
end