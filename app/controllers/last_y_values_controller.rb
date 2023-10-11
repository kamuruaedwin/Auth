# app/controllers/last_y_values_controller.rb

class LastYValuesController < ApplicationController
  def create
    
    last_y_value = LastYValue.new(last_y_value_params)
    if last_y_value.save
      render json: { status: 'success' }
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  # New action to retrieve and display LastYValue records
  def index
    @last_y_values = LastYValue.all
  end

  private

  def last_y_value_params
    params.permit(:hashvalue, :burst_value)
  end
end
