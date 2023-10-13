class User < ApplicationRecord
  has_secure_password
  has_many :bets, dependent: :destroy #destroys all bets on user deletion
  has_many :deposits
  has_many :messages, dependent: :destroy
  has_many :withdraws
  has_many :burst_data

  # validates :firstname, presence: true
  # validates :middlename, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  # generates_token_for :password_reset, expires_in: 8.minutes do #generates tokens that dont have to be stored in the database for on time use
  #   password_salt&.last(4) #adds last 4 digits of the password to the password salt
  # end
     

     def self.logged_in_count
        where(logged_in: true).count
     end

      def self.count_users_with_bets
        joins(:bets).distinct.count
      end
end

 
