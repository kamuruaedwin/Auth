# app/controllers/animations_controller.rb
class AnimationsController < ApplicationController
  # ... (other actions)

  def save_data
    # Retrieve the hashvalue and burstvalue from the AJAX request parameters
    hashvalue = params[:hashvalue]
    burst_value = params[:burst_value]

    # Create a new AnimationData record and save it to the database
    animation_data = AnimationData.new(hashvalue: hashvalue, burst_value: burst_value)
    if animation_data.save
      render json: { message: 'Data saved successfully' }
    else
      render json: { message: 'Data could not be saved' }, status: :unprocessable_entity
    end
  end

  # ... (other actions)
end
