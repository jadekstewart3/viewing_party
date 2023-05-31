class User < ApplicationRecord

  validates_presence_of :name,
                        :email,
                        :password_digest
  has_secure_password

  validates :email, uniqueness: true

  has_many :party_users
  has_many :parties, through: :party_users

  def host?(party)
    user_party = PartyUser.find_by(party: party)
    user_party.user_id == self.id
  end

  def my_parties
		parties.joins(:party_users).where(party_users: {host: true}).distinct
	end

	def party_invites
		parties.joins(:party_users).where(party_users: {host: false}).distinct
	end
end
