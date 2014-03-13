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
  validates :phone_number, numericality: true, length: { is: 10 }, on: :update

  def full_name
    self.first_name + " " + self.last_name
  end

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[signup createprofile]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def lived_in
    houses.map(&:name).join(', ')

    # (houses.map do |h|
    #   h.name
    # end).join(', ')
  end

end
