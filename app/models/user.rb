class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  attr_writer :current_step

  has_many :tenancies
  has_many :houses, through: :tenancies
  has_many :roommates, through: :houses, source: :tenants
  has_many :comments
  has_many :shoppinglists

  has_many :created_houses, class_name: "House"
  has_many :chores
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :first_name, :last_name, on: :update
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  validates_format_of :phone_number, :with => /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/, on: :create

  def full_name
    self.first_name + " " + self.last_name
  end

  def lived_in
    houses.map(&:name).join(', ')

    # (houses.map do |h|
    #   h.name
    # end).join(', ')
  end

end
