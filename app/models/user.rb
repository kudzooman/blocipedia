class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :collaborators

  has_many :wikis, through: :collaborators

  #has_many :collaborators
  #has_many :wikis through: :collaborators
  # wikis => wikis this user is a colloaborotr on
end
