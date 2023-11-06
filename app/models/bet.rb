# app/models/bet.rb
class Bet < ApplicationRecord
  
  belongs_to :user
  

  # Validation rules for the Bet model
  validates :stake_amount, presence: true
  validates :betid, presence: true
  validates :predicted_y_value, presence: true
  validate :stake_amount_less_than_or_equal_to_balance


  private

  def stake_amount_less_than_or_equal_to_balance
    if stake_amount > user.balance
      errors.add(:stake_amount, "cannot be greater than your balance")
    end
  end


end
