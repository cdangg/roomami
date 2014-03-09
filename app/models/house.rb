class House < ActiveRecord::Base
  has_many :chores
  has_many :tenancies
  has_many :tenants, through: :tenancies, source: 'user'
  has_many :comments
  belongs_to :admin, class_name: "User", foreign_key: :user_id
  geocoded_by :full_address
  validates_presence_of :name, :address, :city
  after_validation :geocode

  def full_address
    return [address, city].join(', ')
  end

end
