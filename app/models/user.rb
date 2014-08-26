class User < ActiveRecord::Base

	# Relationships
	has_many :articles

	# Validations
	validates :email, :password, :first_name, :last_name,
		presence: true

	validates :email,
		format: { with: /@/ }

	validates :password,
		length: { in: 12..128 }

	# Methods
	def full_name
		first_name + " " + last_name
	end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :timeoutable,
         :recoverable, :trackable, :lockable
end
