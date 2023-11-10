# app/controllers/animation_controller.rb
class AnimationController < ApplicationController
  def show
    @user= current_user
    render 'animation'# Any logic or data you want to pass to the view
  end
end
