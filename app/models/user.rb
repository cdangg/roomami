class User < ActiveRecord::Base
  has_many :tenancies
  has_many :houses, through: :tenancies
  has_many :roommates, through: :houses, source: :tenants

  has_many :created_houses, class_name: "House"
  has_many :chores
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  validates :phone_number, numericality: true, length: { is: 10 }, :on => :update


end
