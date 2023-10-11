# app/models/bet.rb
class Bet < ApplicationRecord
  belongs_to :user

  # Validation rules for the Bet model
  validates :stake_amount, presence: true
  validates :betid, presence: true
  validates :predicted_y_value, presence: true
  validate :stake_amount_less_than_or_equal_to_balance

  # Method to calculate the outcome
  def calculate_outcome(burst_value)
    if burst_value >= predicted_y_value
      outcome=stake_amount * predicted_y_value
    else
      0
    end
  end

  private

  def stake_amount_less_than_or_equal_to_balance
    if stake_amount > user.balance
      errors.add(:stake_amount, "cannot be greater than your balance")
    end
  end
end
