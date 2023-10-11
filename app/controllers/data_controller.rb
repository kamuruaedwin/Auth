# app/controllers/data_controller.rb
class DataController < ApplicationController
  def receive_data
    # Access the data from the JavaScript request
    data = params[:data]

    # Process the data or save it to the database
    # ...

    # Respond with a JSON message
  #   render json: { message: 'Data received successfully' }
  # end
  # Create a new record in the database
    animation = Animation.new(last_y_value: data[:last_y_value], animation_hash: data[:animation_hash])

    if animation.save
      render json: { message: 'Data received and saved successfully' }
    else
      render json: { errors: animation.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
