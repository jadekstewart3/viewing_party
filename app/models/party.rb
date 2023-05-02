class Party < ApplicationRecord
  validates_presence_of :date,
                        :start_time,
                        :duration,
                        :movie_id
  has_many :party_users
  has_many :users, through: :party_users
end
