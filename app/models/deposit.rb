class Deposit < ApplicationRecord
  belongs_to :user
  before_action :authenticate_user!

end
