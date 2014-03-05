class User < ActiveRecord::Base
  has_many :houses, through: :tenancies
  has_many :chores
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

end
